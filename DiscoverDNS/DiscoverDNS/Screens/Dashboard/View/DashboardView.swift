//
//  DashboardView.swift
//  DiscoverDNS
//
//  Created by Phan Anh Duy on 07/12/2023.
//
//

import SwiftUI

// MARK: struct constIDViewDashboardView
/// List IDview of all views as a const variable
struct constIDViewDashboardView {
    // TODO: Define IDView of all view compenents in here
    // Example with naming convention for this
    // static let _idView_<ViewComponent> = "_idView_<ViewComponent>"
}

// MARK: protocol DashboardViewprotocol
/// protocol DashboardViewprotocol
protocol DashboardViewprotocol: BaseViewProtocol {
    
}

// MARK: Struct DashboardView
/// Contruct main view
struct DashboardView : View, DashboardViewprotocol {
    @ObservedObject var viewmodel: DashboardViewModel
    
    // Contruct main view
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // Contruct searching textfield
                textFieldSearch(viewmodel: viewmodel)
                
                // contruct List view
                listingDNSServicesView(viewmodel: viewmodel)
            }
            .navigationTitle("DNS Services")
            
            // contruct loading view if discovering DNS Services is not completed
            if !viewmodel.discoverDNSCompleted {
                viewLoading()
            }
        }
        // Fire discovering DNS Services whenever this view was appeared
        .onAppear(perform: {
            viewmodel.startDiscoveringDNS()
        })
    }
}

/// Contruct searching DSN service as TextFiled view
/// NOTE: We also support Textfield view for iOS 14 and iOS 17++
fileprivate struct textFieldSearch: View {
    @ObservedObject var viewmodel: DashboardViewModel
    
    var body: some View {
        // contruct Textfield for iOS 17++
        if #available(iOS 17.0, *) {
            return TextField("Service name", text: $viewmodel.searchDNS)
                .font(.body)
                .padding()
                .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.2662717301)))
                .cornerRadius(20)
                .padding(.horizontal, 20)
                .onChange(of: viewmodel.searchDNS) {
                    viewmodel.filterDNS()
                }
        } else {
            // Contruct Textfield for iOS 14 to < 17
            return TextField("Service name", text: $viewmodel.searchDNS)
                .font(.body)
                .padding()
                .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.2662717301)))
                .cornerRadius(20)
                .padding(.horizontal, 20)
                .onChange(of: viewmodel.searchDNS, perform: { value in
                    viewmodel.searchDNS = value
                    viewmodel.filterDNS()
                })
        }
    }
}

/// Contruct Listing of DNS services as List View
fileprivate struct listingDNSServicesView: View {
    @ObservedObject var viewmodel: DashboardViewModel
    
    var body: some View {
        return List {
            ForEach(viewmodel.arrFilteredDNSServices.indices, id: \.self) { index in
                let serviceName = viewmodel.arrFilteredDNSServices[index]
                
                NavigationLink {
                    viewmodel.navigateDiscoverDNSServices(serviceName)
                } label: {
                    Text(serviceName)
                        .font(.title3)
                        .padding()
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

// MARK: Preview
#Preview {
    return DashboardBuilder.setupdashboard()
}
