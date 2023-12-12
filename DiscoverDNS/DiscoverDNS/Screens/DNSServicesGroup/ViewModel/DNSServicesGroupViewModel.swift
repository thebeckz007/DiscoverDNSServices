//
//  DNSServicesGroupViewModel.swift
//  DiscoverDNS
//
//  Created by Phan Anh Duy on 08/12/2023.
//
//

import Foundation

// MARK: Protocol DNSServicesGroupViewModelprotocol
/// protocol DNSServicesGroupViewModelprotocol
protocol DNSServicesGroupViewModelprotocol: BaseViewModelProtocol {
    func filterDNS()
    func navigateDiscoverDNSServiceDetail(_ service: DiscoverDNSService) -> DNSServiceDetailView
}

// MARK: class DNSServicesGroupViewModel
/// class DNSServicesGroupViewModel
class DNSServicesGroupViewModel: ObservableObject, DNSServicesGroupViewModelprotocol {
    private var arrDNSServices: [DiscoverDNSService]?
    
    @Published var arrFilteredDNSServices: [DiscoverDNSService]?
    @Published var serviceName: String
    @Published var searchDNS = ""
    
    private var model: DNSServicesGroupModelprotocol
    
    init(serviceName: String, dnsServices: [DiscoverDNSService]?, model: DNSServicesGroupModelprotocol) {
        self.arrDNSServices = dnsServices
        self.arrFilteredDNSServices = self.arrDNSServices
        self.serviceName = serviceName
        self.model = model
    }
    
    func navigateDiscoverDNSServiceDetail(_ service: DiscoverDNSService) -> DNSServiceDetailView {
        return DNSServiceDetailBuilder.setupDNSServiceDetail(service: service)
    }
    
    func filterDNS() {
        if let arrDNS = self.arrDNSServices {
            let keywordRegex = "\\b(\\w*" + searchDNS.lowercased() + "\\w*)\\b"
            
            if searchDNS.count > 1 {
                var arrFilteredDNSServices = [DiscoverDNSService]()
                arrDNS.forEach { service in
                    // support to filter service type, service domain, interface index
                    var searchContent = "\(service.type.rawValue)" + "\(service.domain.rawValue)" + service.interfaceIndex.description + "\(service.type.fullDescription())"
                    searchContent = searchContent.replacingOccurrences(of: "_", with: " ")
                    searchContent = searchContent.replacingOccurrences(of: ".", with: " ")
                    
                    if searchContent.lowercased().range(of: keywordRegex, options: .regularExpression) != nil {
                        arrFilteredDNSServices.append(service)
                    }
                }
                self.arrFilteredDNSServices = arrFilteredDNSServices
            } else {
                self.arrFilteredDNSServices = self.arrDNSServices
            }
        }
    }
}
