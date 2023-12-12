//
//  DashboardModel.swift
//  DiscoverDNS
//
//  Created by Phan Anh Duy on 07/12/2023.
//
//

import Foundation

// MARK: Protocol DashboardModelprotocol
/// protocol DashboardModelprotocol
protocol DashboardModelprotocol: BaseModelProtocol {
    func startDiscoveringDNS(completion: @escaping DiscoverDNSModule.discoveryDNSServicesCompletion)
}

// MARK: struct DashboardModel
/// struct DashboardModel
struct DashboardModel: DashboardModelprotocol {
    //
    private var dnsModule: DiscoverDNSProtocol
    
    func startDiscoveringDNS(completion: @escaping DiscoverDNSModule.discoveryDNSServicesCompletion) {
        self.dnsModule.startDiscoveringDNS(completion: completion)
    }
    
    init(dnsModule: DiscoverDNSProtocol) {
        self.dnsModule = dnsModule
    }
}
