//
//  DashboardBuilder.swift
//  DiscoverDNS
//
//  Created by Phan Anh Duy on 07/12/2023.
//
//

import Foundation

// MARK: Protocol DashboardBuilderprotocol
/// protcol DashboardBuilderprotocol
protocol DashboardBuilderprotocol: BaseBuilderProtocol {
    
}

// MARK: class DashboardBuilder
/// class DashboardBuilder
class DashboardBuilder: DashboardBuilderprotocol {
     class func setupdashboard() -> DashboardView {
         let model = DashboardModel(dnsModule: DiscoverDNSModule.sharedInstance)
         let viewmodel = DashboardViewModel(model: model)
         let view = DashboardView(viewmodel: viewmodel)
         
         return view
     }
}
