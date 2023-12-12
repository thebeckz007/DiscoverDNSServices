//
//  DNSServiceDetailBuilder.swift
//  DiscoverDNS
//
//  Created by Phan Anh Duy on 07/12/2023.
//
//

import Foundation

// MARK: Protocol DNSServiceDetailBuilderprotocol
/// protcol DNSServiceDetailBuilderprotocol
protocol DNSServiceDetailBuilderprotocol: BaseBuilderProtocol {
    
}

// MARK: class DNSServiceDetailBuilder
/// class DNSServiceDetailBuilder
class DNSServiceDetailBuilder: DNSServiceDetailBuilderprotocol {
    class func setupDNSServiceDetail(service: DiscoverDNSService) -> DNSServiceDetailView {
        let model = DNSServiceDetailModel(dnsModule: DiscoverDNSModule.sharedInstance, wikipediaModule: WikipediaModule.sharedInstance)
        let viewmodel = DNSServiceDetailViewModel(model: model, dnsService: service)
        let view = DNSServiceDetailView(viewmodel: viewmodel)
         
         return view
     }
}
