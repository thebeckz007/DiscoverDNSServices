//
//  DiscoverDNSApp.swift
//  DiscoverDNS
//
//  Created by Phan Anh Duy on 07/12/2023.
//

import SwiftUI
import SwiftData

@main
struct DiscoverDNSApp: App {
    var body: some Scene {
        WindowGroup {
            DashboardBuilder.setupdashboard()
        }
    }
}
