//
//  DashboardModelTestSpec.swift
//  DiscoverDNSTests
//
//  Created by Phan Anh Duy on 10/12/2023.
//

import Quick
import Nimble
import Foundation
import DNSServiceDiscovery

@testable import DiscoverDNS

fileprivate let expectedValue = [DiscoverDNSService(name: "Airplay", type: DNSServiceType.printer, domain: "local", interfaceIndex: 14)]

class DashboardModelTestSpec: QuickSpec {
    override class func spec() {
        var model: DashboardModel?

        beforeEach {
            let dnsServicesModule = MockDiscoverDNSModule()
            model = DashboardModel(dnsModule: dnsServicesModule)
        }
        
        // testsuite of methods
        describe("Test methods") {
            // testsuite of start discovering DNS services
            context("Test DNS service method") {
                it("Discover an DNS service as exectedValue Airplay") {
                    model?.startDiscoveringDNS(completion: { data in
                        expect(data).to(equal(expectedValue))
                    })
                }
            }
        }
    }
}

// MARK: Mock
fileprivate class MockDiscoverDNSModule: DiscoverDNSProtocol {
    // completion
    typealias discoveryDNSServicesCompletion = (_ data: [DiscoverDNSService]?) -> Void
    typealias lookupDNSServiceCompletion = (_ data: DiscoverDNSService?) -> Void
    
    func startDiscoveringDNS(completion: @escaping discoveryDNSServicesCompletion) {
        DispatchQueue.global().async {
            completion(expectedValue)
        }
    }
    
    func lookupDNSService(_ service: DiscoverDNSService, completion: @escaping lookupDNSServiceCompletion) {

    }
}
