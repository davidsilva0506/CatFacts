//
//  XCTestCase+JSON.swift
//  CatFactsTests
//
//  Created by David Silva on 28/11/2023.
//
import XCTest

extension XCTestCase {
    
    public enum TestError: Error {
        
        case unableToCast(object: String, into: String)
        case fileNotFound(fileName: String)
    }

    public func loadJSON<T: Any>(from fileName: String) throws -> T {

        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {

            throw TestError.fileNotFound(fileName: fileName)
        }

        let data = try Data(contentsOf: url)
        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)

        guard let object = json as? T else {

            throw TestError.unableToCast(object: String(describing: json.self), into: String(describing: T.self))
        }

        return object
    }

    public func load<T: Decodable>(from fileName: String) throws -> T {

        let file = try self.loadJSON(from: fileName) as Any
        let data = try JSONSerialization.data(withJSONObject: file, options: [.prettyPrinted])

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return try decoder.decode(T.self, from: data)
    }
}
