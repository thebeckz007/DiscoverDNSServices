//
//  DNSServiceWikipediapageModel.swift
//  DiscoverDNS
//
//  Created by Phan Anh Duy on 09/12/2023.
//
//

import Foundation

// MARK: Protocol DNSServiceWikipediapageModelprotocol
/// protocol DNSServiceWikipediapageModelprotocol
protocol DNSServiceWikipediapageModelprotocol: BaseModelProtocol {
    func searchWikipedia(keysearch: String, completion: @escaping WikipediaModule.wikipediaModuleCompletion)
}

// MARK: struct DNSServiceWikipediapageModel
/// struct DNSServiceWikipediapageModel
struct DNSServiceWikipediapageModel: DNSServiceWikipediapageModelprotocol {
    private var wikipediaModule: WikipediaModuleProtocol
    
    init(wikipediaModule: WikipediaModuleProtocol) {
        self.wikipediaModule = wikipediaModule
    }
    
    func searchWikipedia(keysearch: String, completion: @escaping WikipediaModule.wikipediaModuleCompletion) {
        self.wikipediaModule.searchWikipedia(keysearch: keysearch, completion: completion)
    }
}
