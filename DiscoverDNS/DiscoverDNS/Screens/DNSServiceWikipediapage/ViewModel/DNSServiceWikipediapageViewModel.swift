//
//  DNSServiceWikipediapageViewModel.swift
//  DiscoverDNS
//
//  Created by Phan Anh Duy on 09/12/2023.
//
//

import Foundation

// MARK: Protocol DNSServiceWikipediapageViewModelprotocol
/// protocol DNSServiceWikipediapageViewModelprotocol
protocol DNSServiceWikipediapageViewModelprotocol: BaseViewModelProtocol {
    func searchWikipedia()
}

// MARK: class DNSServiceWikipediapageViewModel
/// class DNSServiceWikipediapageViewModel
class DNSServiceWikipediapageViewModel: ObservableObject, DNSServiceWikipediapageViewModelprotocol {
    private var model: DNSServiceWikipediapageModelprotocol
    var keySearch: String
    @Published var wikipediaPage: [String]?
    
    init(model: DNSServiceWikipediapageModelprotocol, keySearch: String) {
        self.model = model
        self.keySearch = keySearch
    }
    
    func searchWikipedia() {
        self.model.searchWikipedia(keysearch: self.keySearch) { data in
            DispatchQueue.main.async {
                self.wikipediaPage = data
            }
        }
    }
}
