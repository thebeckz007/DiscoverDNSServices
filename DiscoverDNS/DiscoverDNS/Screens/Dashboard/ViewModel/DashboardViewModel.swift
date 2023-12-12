//
//  DashboardViewModel.swift
//  DiscoverDNS
//
//  Created by Phan Anh Duy on 07/12/2023.
//
//

import Foundation

// MARK: Protocol DashboardViewModelprotocol
/// protocol DashboardViewModelprotocol
protocol DashboardViewModelprotocol: BaseViewModelProtocol {
    func startDiscoveringDNS()
    func filterDNS()
    func navigateDiscoverDNSServices(_ serviceName: String) -> DNSServicesGroupView
}

// MARK: class DashboardViewModel
/// class DashboardViewModel
class DashboardViewModel: ObservableObject, DashboardViewModelprotocol {
    //
    private var model: DashboardModelprotocol
    
    private var arrDNSServicesGroupByName = [String]()
    private var arrDNSServices = [String: [DiscoverDNSService]]()
    
    @Published var arrFilteredDNSServices = [String]()
    @Published var discoverDNSCompleted = true
    @Published var searchDNS = ""
    
    init(model: DashboardModelprotocol) {
        self.model = model
    }
    
    func startDiscoveringDNS() {
        self.discoverDNSCompleted = false
        self.model.startDiscoveringDNS { data in
            DispatchQueue.main.async {
                if let arrData = data {
                    self.arrDNSServices = Dictionary(grouping: arrData, by: {$0.name})
                    self.arrDNSServicesGroupByName = self.arrDNSServices.map{$0.key}.sorted()
                    self.arrFilteredDNSServices = self.arrDNSServicesGroupByName
                }
                
                self.discoverDNSCompleted = true
            }
        }
    }
    
    func navigateDiscoverDNSServices(_ serviceName: String) -> DNSServicesGroupView {
        let arrServices = self.arrDNSServices[serviceName]
        return DNSServicesGroupBuilder.setupDNSServicesGroup(serviceName: serviceName, services: arrServices)
    }
    
    func filterDNS() {
        let keywordRegex = "\\b(\\w*" + searchDNS.lowercased() + "\\w*)\\b"

        if searchDNS.count > 1 {
            var arrFilteredDNSServices = [String]()
            self.arrDNSServicesGroupByName.forEach { serviceName in
                // support to filter by service name
                let searchContent = serviceName
                if searchContent.lowercased().range(of: keywordRegex, options: .regularExpression) != nil {
                    arrFilteredDNSServices.append(serviceName)
                }
            }
            self.arrFilteredDNSServices = arrFilteredDNSServices
        } else {
            self.arrFilteredDNSServices = self.arrDNSServicesGroupByName
        }
    }
}
