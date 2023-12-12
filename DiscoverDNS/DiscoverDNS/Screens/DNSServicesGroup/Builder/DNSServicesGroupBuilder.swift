//
//  DNSServicesGroupBuilder.swift
//  DiscoverDNS
//
//  Created by Phan Anh Duy on 08/12/2023.
//
//

import Foundation

// MARK: Protocol DNSServicesGroupBuilderprotocol
/// protcol DNSServicesGroupBuilderprotocol
protocol DNSServicesGroupBuilderprotocol: BaseBuilderProtocol {
    
}

// MARK: class DNSServicesGroupBuilder
/// class DNSServicesGroupBuilder
class DNSServicesGroupBuilder: DNSServicesGroupBuilderprotocol {
     class func setupDNSServicesGroup(serviceName: String ,services: [DiscoverDNSService]?) -> DNSServicesGroupView {
         let model = DNSServicesGroupModel()
         let viewmodel = DNSServicesGroupViewModel(serviceName: serviceName, dnsServices: services, model: model)
         let view = DNSServicesGroupView(viewModel: viewmodel)
          
          return view
      }
}
