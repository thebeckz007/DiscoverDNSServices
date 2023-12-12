//
//  WikipediaModule.swift
//  DiscoverDNS
//
//  Created by Phan Anh Duy on 09/12/2023.
//

import Foundation
import WikipediaKit

protocol WikipediaModuleProtocol {
    func searchWikipedia(keysearch: String, completion: @escaping WikipediaModule.wikipediaModuleCompletion)
}

class WikipediaModule: WikipediaModuleProtocol {
    typealias wikipediaModuleCompletion = (_ data: [String]?) -> Void
    
    static let sharedInstance = WikipediaModule()
    private let wikipedia = Wikipedia.shared
    
    func setupWikipedia() {
        WikipediaNetworking.appAuthorEmailForAPI = "thebeckz007@gmail.com"
    }
    
    func searchWikipedia(keysearch: String, completion: @escaping wikipediaModuleCompletion) {
        wikipedia.requestOptimizedSearchResults(language: WikipediaLanguage("en"), term: keysearch) { (searchResults, error) in
            guard error == nil else { return }
            guard let searchResults = searchResults else { return }
            
            var arrDisplayText: [String] = []
            for articlePreview in searchResults.items {
                arrDisplayText.append(articlePreview.displayText)
            }
            
            completion(arrDisplayText)
        }
    }
}
