//
//  DNSServiceDetailViewModel.swift
//  DiscoverDNS
//
//  Created by Phan Anh Duy on 07/12/2023.
//
//

import Foundation

// MARK: Protocol DNSServiceDetailViewModelprotocol
/// protocol DNSServiceDetailViewModelprotocol
protocol DNSServiceDetailViewModelprotocol: BaseViewModelProtocol {
    func lookupDNSService()
    func navigateWikipediapage(keysearch: String) -> DNSServiceWikipediapageView
}

// MARK: class DNSServiceDetailViewModel
/// class DNSServiceDetailViewModel
class DNSServiceDetailViewModel: ObservableObject, DNSServiceDetailViewModelprotocol {
    @Published var DNSService: DiscoverDNSService?
    private var rawDNSService: DiscoverDNSService
    
    private var model: DNSServiceDetailModelprotocol
    
    init(model: DNSServiceDetailModelprotocol, dnsService: DiscoverDNSService) {
        self.rawDNSService = dnsService
        self.model = model
    }
    
    func lookupDNSService() {
        self.model.lookupDNSService(self.rawDNSService) { data in
            DispatchQueue.main.async {
                self.DNSService = data
            }
        }
    }
    
    func navigateWikipediapage(keysearch: String) -> DNSServiceWikipediapageView {
        return DNSServiceWikipediapageBuilder.setupDNSServiceWikipediapage(keySearch: keysearch)
    }
}
