//
//  CatListViewController.swift
//  CatFacts
//
//  Created by Kerem Gunduz on 30/03/2021.
//

import UIKit

class CatListViewController: UIViewController {
    
    private enum Constants {
        
        static let title = "Cat Facts"
        static let cellIdentifier = "CatFactTableViewCell"
        static let searchBarPlaceholder = "Search cat fact"
        static let errorTitle = "Oops"
        static let buttonTitle = "Ok"
        static let isNewPeriod = 90
    }
    
    private let viewModel: CatListViewModel
    private let searchController = UISearchController()
    
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = .zero
        tableView.separatorColor = .purple
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0,
                                                         y: 0,
                                                         width: 0,
                                                         height: CGFloat.leastNormalMagnitude))
        tableView.dataSource = self

        return tableView
    }()
   
    init(viewModel: CatListViewModel) {

        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.delegate = self
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.addSubviews()
        self.configureView()
        self.defineSubviewConstraints()
        self.requestData()
    }
}

private extension CatListViewController {
    
    func requestData() {
        
        self.showActivityOverlay()
        self.viewModel.requestCatFacts()
    }

    func addSubviews() {
        
        self.view.add(self.tableView)
    }
    
    func configureView() {
        
        self.title = Constants.title
        self.navigationItem.searchController = self.searchController
       
        self.tableView.register(CatFactTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
    }
    
    func defineSubviewConstraints() {
        
        self.tableView.pin(to: self.view)
    }
    
    func showError(message: String) {
        
        let alert = UIAlertController(title: Constants.errorTitle,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.buttonTitle, style: .destructive))
        
        self.present(alert, animated: true)
    }
}

extension CatListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.viewModel.filteredFacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let fact = self.viewModel.filteredFacts[safe: indexPath.row] else {

            assertionFailure("IndexPath out of bounds")
            return UITableViewCell()
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as? CatFactTableViewCell else {
            
            return UITableViewCell()
        }

        cell.selectionStyle = .none
        
        let daysSinceCreated = fact.createdAt.daysBetween(date: Date())
        let isNew = abs(daysSinceCreated) <= Constants.isNewPeriod
        
        cell.configure(catFactText: fact.text, isVerified: fact.status.verified, isNew: isNew)

        return cell
    }
}

extension CatListViewController: CatListViewModelDelegate {
    
    func viewModel(_ viewModel: Any, loaded: Bool, error: Error?) {
        
        DispatchQueue.main.async { [weak self] in
            
            guard let self else { return }

            self.hideActivityOverlay()
            
            if let error {
                
                self.showError(message: error.localizedDescription)
                
            } else if loaded == true {
                
                self.tableView.reloadData()
            }
        }
    }
    
    func viewModel(_ viewModel: Any, updated: Bool) {
        
        DispatchQueue.main.async { [weak self] in
            
            guard let self else { return }
            
            if updated == true {
                
                self.tableView.reloadData()
            }
        }
    }
}

extension CatListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
    
        guard let searchText = searchController.searchBar.text else { return }
        
        if searchText.isEmpty {

            self.viewModel.restoreCurrentFacts()
            
        } else {
            
            self.viewModel.filterCurrentFacts(searchTerm: searchText)
        }
    }
}

extension CatListViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.viewModel.restoreCurrentFacts()
    }
}
