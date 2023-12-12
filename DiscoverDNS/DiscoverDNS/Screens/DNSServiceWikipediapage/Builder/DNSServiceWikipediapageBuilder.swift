//
//  DNSServiceWikipediapageBuilder.swift
//  DiscoverDNS
//
//  Created by Phan Anh Duy on 09/12/2023.
//
//

import Foundation

// MARK: Protocol DNSServiceWikipediapageBuilderprotocol
/// protcol DNSServiceWikipediapageBuilderprotocol
protocol DNSServiceWikipediapageBuilderprotocol: BaseBuilderProtocol {
    
}

// MARK: class DNSServiceWikipediapageBuilder
/// class DNSServiceWikipediapageBuilder
class DNSServiceWikipediapageBuilder: DNSServiceWikipediapageBuilderprotocol {
    class func setupDNSServiceWikipediapage(keySearch: String) -> DNSServiceWikipediapageView {
        let model = DNSServiceWikipediapageModel(wikipediaModule: WikipediaModule.sharedInstance)
        let viewmodel = DNSServiceWikipediapageViewModel(model: model, keySearch: keySearch)
        let view = DNSServiceWikipediapageView(viewmodel: viewmodel)
         
         return view
     }
}
