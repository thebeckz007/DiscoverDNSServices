//
//  DNSServiceWikipediapageView.swift
//  DiscoverDNS
//
//  Created by Phan Anh Duy on 09/12/2023.
//
//

import SwiftUI

// MARK: struct constIDViewDNSServiceWikipediapageView
/// List IDview of all views as a const variable
struct constIDViewDNSServiceWikipediapageView {
    // TODO: Define IDView of all view compenents in here
    // Example with naming convention for this
    // static let _idView_<ViewComponent> = "_idView_<ViewComponent>"
}

// MARK: protocol DNSServiceWikipediapageViewprotocol
/// protocol DNSServiceWikipediapageViewprotocol
protocol DNSServiceWikipediapageViewprotocol: BaseViewProtocol {
    
}

// MARK: Struct DNSServiceWikipediapageView
/// Contruct main view
struct DNSServiceWikipediapageView : View, DNSServiceWikipediapageViewprotocol {
    @ObservedObject var viewmodel: DNSServiceWikipediapageViewModel
    
    var body: some View {
        ZStack {
            if let wikipage = viewmodel.wikipediaPage {
                List {
                    ForEach(wikipage, id: \.self) { item in
                        Text(item)
                            .padding()
                    }
                }
                .listStyle(PlainListStyle())
            } else {
                viewLoading()
            }
        }
        .onAppear(perform: {
            self.viewmodel.searchWikipedia()
        })
        .navigationTitle(self.viewmodel.keySearch)
    }
}

#Preview {
    return DNSServiceWikipediapageBuilder.setupDNSServiceWikipediapage(keySearch: "Apple Inc")
}
