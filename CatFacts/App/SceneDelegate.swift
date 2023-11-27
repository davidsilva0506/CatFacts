//
//  SceneDelegate.swift
//  CatFacts
//
//  Created by Kerem Gunduz on 30/03/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var core: Core?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        self.setupCore()
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        
        guard let window = self.window else { return }
        
        window.windowScene = windowScene
        window.rootViewController = self.rootViewController()
        window.makeKeyAndVisible()
    }
}

extension SceneDelegate {
    

    private func setupCore() {
            
        self.core = Core(service: FactsApi())
    }

    private func rootViewController() -> UINavigationController {
        
        guard let core else {
            assertionFailure("We should have core at this stage")
            return UINavigationController()
        }

        let catListViewModel = CatListViewModel(provider: core.service)
        let catListViewController = CatListViewController(viewModel: catListViewModel)
        
        return CatFactsNavigationController(rootViewController: catListViewController)
    }
}
