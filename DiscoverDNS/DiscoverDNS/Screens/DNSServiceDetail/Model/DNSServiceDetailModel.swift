//
//  DNSServiceDetailModel.swift
//  DiscoverDNS
//
//  Created by Phan Anh Duy on 07/12/2023.
//
//

import Foundation
import ServiceDiscovery

// MARK: Protocol DNSServiceDetailModelprotocol
/// protocol DNSServiceDetailModelprotocol
protocol DNSServiceDetailModelprotocol: BaseModelProtocol {
    func lookupDNSService(_ service: DiscoverDNSService, completion: @escaping DiscoverDNSModule.lookupDNSServiceCompletion)
}

// MARK: struct DNSServiceDetailModel
/// struct DNSServiceDetailModel
struct DNSServiceDetailModel: DNSServiceDetailModelprotocol {
    private var dnsModule: DiscoverDNSProtocol
    private var wikipediaModule: WikipediaModuleProtocol
    
    init(dnsModule: DiscoverDNSProtocol, wikipediaModule: WikipediaModuleProtocol) {
        self.dnsModule = dnsModule
        self.wikipediaModule = wikipediaModule
    }
    
    func lookupDNSService(_ service: DiscoverDNSService, completion: @escaping DiscoverDNSModule.lookupDNSServiceCompletion) {
        self.dnsModule.lookupDNSService(service, completion: completion)
    }
}
