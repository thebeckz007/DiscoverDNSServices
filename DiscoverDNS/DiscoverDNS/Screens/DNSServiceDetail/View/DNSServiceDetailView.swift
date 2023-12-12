//
//  DNSServiceDetailView.swift
//  DiscoverDNS
//
//  Created by Phan Anh Duy on 07/12/2023.
//
//

import SwiftUI
import DNSServiceDiscovery

// MARK: struct constIDViewDNSServiceDetailView
/// List IDview of all views as a const variable
struct constIDViewDNSServiceDetailView {
    // TODO: Define IDView of all view compenents in here
    // Example with naming convention for this
    // static let _idView_<ViewComponent> = "_idView_<ViewComponent>"
}

// MARK: protocol DNSServiceDetailViewprotocol
/// protocol DNSServiceDetailViewprotocol
protocol DNSServiceDetailViewprotocol: BaseViewProtocol {
    
}

// MARK: Struct DNSServiceDetailView
/// Contruct main view
struct DNSServiceDetailView : View, DNSServiceDetailViewprotocol {
    @ObservedObject var viewmodel: DNSServiceDetailViewModel
    
    var body: some View {
        ZStack {
            if let service = self.viewmodel.DNSService {
                List {
                    Text("Service Name: \(service.name)")
                    Text("Service Type: \(service.type.description)")
                    
                    HStack {
                        Text("Service Type Name: \(service.type.fullDescription())")
                        Spacer()
                        ZStack{
                            Spacer()
                            Image(systemName: "info.circle").foregroundColor(.blue)
                                .padding()
                            
                            // Hide the narrow icon of navigation link
                            NavigationLink {
                                self.viewmodel.navigateWikipediapage(keysearch: service.type.fullDescription())
                            } label: {
                                EmptyView()
                            }
                            .opacity(0)
                            .padding()
                        }
                        .frame(width: 30, height: 30)
                    }
                    
                    Text("Domain: \(service.domain.description)")
                    Text("Port: \(service.port?.description ?? "")")
                    Text("Interface Index: \(service.interfaceIndex)")
                    
                    // Section of TXT Records
                    DisclosureGroup("TXT Record") {
                        ForEach(service.txtRecord.keys.sorted(), id: \.self) { key in
                            HStack {
                                Text("\(key) : \(service.txtRecord[key] ?? "")")
                                
                                // add button more detail for manufactuter, model, product, ty, usb_mfg
                                let keysearch = key.lowercased()
                                let keySearchSupporting = ["manufacturer", "model", "product", "ty", "usb_mfg"]
                                if keySearchSupporting.contains(keysearch) {
                                    Spacer()
                                    ZStack{
                                        Spacer()
                                        Image(systemName: "info.circle").foregroundColor(.blue)
                                            .padding()
                                        
                                        // Hide the narrow icon of navigation link
                                        NavigationLink {
                                            self.viewmodel.navigateWikipediapage(keysearch: service.txtRecord[key] ?? "")
                                        } label: {
                                            EmptyView()
                                        }
                                        .opacity(0)
                                        .padding()
                                    }
                                    .frame(width: 30, height: 30)
                                }
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
            } else {
                viewLoading()
            }
        }
        .onAppear(perform: {
            self.viewmodel.lookupDNSService()
        })
    }
}

#Preview {
    let model = DNSServiceDetailModel(dnsModule: DiscoverDNSModule.sharedInstance, wikipediaModule: WikipediaModule.sharedInstance)
    let service = DiscoverDNSService(name: "Apple Airplay", type: DNSServiceType.airplay,domain: "local", interfaceIndex: 1, port: 7000, txtRecord: ["model":"MacbookPro18,1", "manufacturer":"Apple", "product":"Macbook"])
    let viewmodel = DNSServiceDetailViewModel(model: model, dnsService: service)
    viewmodel.DNSService = service
    return DNSServiceDetailView(viewmodel: viewmodel)
}
