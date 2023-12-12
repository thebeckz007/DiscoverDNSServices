//
//  DNSServicesGroupView.swift
//  DiscoverDNS
//
//  Created by Phan Anh Duy on 08/12/2023.
//
//

import SwiftUI
import DNSServiceDiscovery

// MARK: struct constIDViewDNSServicesGroupView
/// List IDview of all views as a const variable
struct constIDViewDNSServicesGroupView {
    // TODO: Define IDView of all view compenents in here
    // Example with naming convention for this
    // static let _idView_<ViewComponent> = "_idView_<ViewComponent>"
}

// MARK: protocol DNSServicesGroupViewprotocol
/// protocol DNSServicesGroupViewprotocol
protocol DNSServicesGroupViewprotocol: BaseViewProtocol {
    
}

// MARK: Struct DNSServicesGroupView
/// Contruct main view
struct DNSServicesGroupView : View, DNSServicesGroupViewprotocol {
    @ObservedObject var viewModel: DNSServicesGroupViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            // Contruct searching textfield
            textFieldSearch(viewmodel: viewModel)
            
            // contruct List view
            listingDNSServicesView(viewmodel: viewModel)
        }
    }
}

/// Contruct searching DSN service as TextFiled view
/// NOTE: We also support Textfield view for iOS 14 and iOS 17++
fileprivate struct textFieldSearch: View {
    @ObservedObject var viewmodel: DNSServicesGroupViewModel
    
    var body: some View {
        // contruct Textfield for iOS 17++
        if #available(iOS 17.0, *) {
            TextField("Search", text: $viewmodel.searchDNS)
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
            TextField("Search", text: $viewmodel.searchDNS)
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
    @ObservedObject var viewmodel: DNSServicesGroupViewModel
    
    var body: some View {
        return VStack {
            if let arrDNSServices = viewmodel.arrFilteredDNSServices {
                List {
                    ForEach(arrDNSServices) { service in
                        NavigationLink {
                            viewmodel.navigateDiscoverDNSServiceDetail(service)
                        } label: {
                            HStack{
                                Text("\(service.type.fullDescription())")
                                    .padding()
                                Text("\(service.domain.rawValue)")
                                    .padding()
                                Text("\(service.interfaceIndex.description)")
                                    .padding()
                            }
                        }
                    }
                }
                .navigationBarTitle(viewmodel.serviceName)
                .listStyle(PlainListStyle())
            } else {
                Text("Something went wrong").foregroundColor(.red)
            }
        }
    }
}

// MARK: Preview
#Preview {
    // Mock DNS services data
    let serviceName = "Service Name"
    let arrServices: [DiscoverDNSService] = [
        DiscoverDNSService(name: serviceName, type: DNSServiceType.printer, domain: "local", interfaceIndex: 14),
        DiscoverDNSService(name: serviceName, type: DNSServiceType.airplay, domain: "local", interfaceIndex: 1),
        DiscoverDNSService(name: serviceName, type: DNSServiceType.homeSharing, domain: "local", interfaceIndex: 4)]
    return DNSServicesGroupBuilder.setupDNSServicesGroup(serviceName: serviceName, services: arrServices)
}
