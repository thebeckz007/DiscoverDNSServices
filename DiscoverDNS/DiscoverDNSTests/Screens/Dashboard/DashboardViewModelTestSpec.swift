//
//  DashboardViewModelTestSpec.swift
//  DiscoverDNSTests
//
//  Created by Phan Anh Duy on 10/12/2023.
//

import Quick
import Nimble
import Foundation
import DNSServiceDiscovery

@testable import DiscoverDNS

fileprivate let hasDataSearchingExpected = "Airplay"
fileprivate let noDataSearchingExpected = "Football"
fileprivate let expectedValue = [
    DiscoverDNSService(name: "Fuji Printer", type: DNSServiceType.printer, domain: "local", interfaceIndex: 14),
    DiscoverDNSService(name: hasDataSearchingExpected, type: DNSServiceType.airplay, domain: "local", interfaceIndex: 1),
    DiscoverDNSService(name: "Home sharing", type: DNSServiceType.homeSharing, domain: "local", interfaceIndex: 4)]

class DashboardViewModelTestSpec: QuickSpec {
    override class func spec() {
        var viewmodel: DashboardViewModel?

        beforeEach {
            let model = MockDashboardModel()
            viewmodel = DashboardViewModel(model: model)
        }
        
        // testsuite of methods
        describe("Test methods") {
            // testsuite of start discovering DNS services
            context("Test DNS service method") {
                beforeEach {
                    // perform discovering DNS servcies task
                    viewmodel?.startDiscoveringDNS()
                }
                
                it("Discovering DNS services not start") {
                    expect(viewmodel?.discoverDNSCompleted).to(equal(false))
                }
                
                it("Discovering DNS Services is completed") {
                    expect(viewmodel?.discoverDNSCompleted).toEventually(equal(true))
                }
                
                it("Discovering some DNS Services as expected value above") {
                    let arrDNSServices = Dictionary(grouping: expectedValue, by: {$0.name})
                    let arrDNSServicesGroupByName = arrDNSServices.map{$0.key}.sorted()
                    let expectedArrValue = arrDNSServicesGroupByName
                    
                    expect(viewmodel?.arrFilteredDNSServices).toEventually(equal(expectedArrValue))
                }
            }
            
            context("Test filter DNS services by service name") {
                beforeEach {
                    // perform discovering DNS servcies task
                    viewmodel?.startDiscoveringDNS()
                }
                
                it("has data with searching by Airplay name") {
                    expect(viewmodel?.arrFilteredDNSServices.count).toEventually(equal(expectedValue.count))
                    
                    viewmodel?.searchDNS = hasDataSearchingExpected
                    viewmodel?.filterDNS()
                    
                    expect(viewmodel?.arrFilteredDNSServices.count).toEventually(equal(1))
                }
                
                it("no data with searching by Football name") {
                    expect(viewmodel?.arrFilteredDNSServices.count).toEventually(equal(expectedValue.count))
                    
                    viewmodel?.searchDNS = noDataSearchingExpected
                    viewmodel?.filterDNS()
                    
                    expect(viewmodel?.arrFilteredDNSServices.count).toEventually(equal(0))
                }
            }
            
            context("Navigate to another view") {
                it("Navigate to DNS services group view") {
                    let anotherview = viewmodel?.navigateDiscoverDNSServices(hasDataSearchingExpected)
                    expect(anotherview).toNot(beNil())
                }
            }
        }
    }
}

// MARK: Mock
fileprivate struct MockDashboardModel: DashboardModelprotocol {
    func startDiscoveringDNS(completion: @escaping DiscoverDNSModule.discoveryDNSServicesCompletion) {
        DispatchQueue.global().async {
            completion(expectedValue)
        }
    }
}
