//
//  DiscoverDNSModule.swift
//  DiscoverDNS
//
//  Created by Phan Anh Duy on 07/12/2023.
//

import Foundation
import DNSServiceDiscovery

// MARK: DiscoverDNSProtocol protocol
protocol DiscoverDNSProtocol {
    func startDiscoveringDNS(completion: @escaping DiscoverDNSModule.discoveryDNSServicesCompletion)
    func lookupDNSService(_ service: DiscoverDNSService, completion: @escaping DiscoverDNSModule.lookupDNSServiceCompletion)
}

// MARK: DiscoverDNSModule class
class DiscoverDNSModule: DiscoverDNSProtocol {
    // completion
    typealias discoveryDNSServicesCompletion = (_ data: [DiscoverDNSService]?) -> Void
    typealias lookupDNSServiceCompletion = (_ data: DiscoverDNSService?) -> Void
    
    /// a shared instance of DiscoverDNSModule as singleton instance
    static let sharedInstance = DiscoverDNSModule()
    
    private let dsnSD = DNSServiceDiscovery()
    
    func startDiscoveringDNS(completion: @escaping discoveryDNSServicesCompletion) {
        let arrSupportingDNSServices: [DNSServiceType] = [.airplay, .companionLink, .http, .pdlDataStream, .printer, .raop, .spotify, .homeSharing, .ssh]
        
        var arrDNSServices = [DiscoverDNSService]()
        
        for serviceType in arrSupportingDNSServices {
            self.dsnSD.lookup(DNSServiceQuery(type: serviceType)) { instances in
                let arrDNS = try! instances.get().map({ item in
                    return DiscoverDNSService(DNSInstance: item)
                })

                arrDNSServices.append(contentsOf: arrDNS)
                completion(arrDNSServices)
            }
        }
    }
    
    func lookupDNSService(_ service: DiscoverDNSService, completion: @escaping lookupDNSServiceCompletion) {
        self.dsnSD.lookup(service.convertToDNSServiceQuery()) { data in
            if case .failure(let failure) = data {
                print("ERROR: \(failure)")
                completion(nil)
            } else {
                let instances = try! data.get()
                if !instances.isEmpty {
                    let arr = instances.filter{ instance in
                        if instance.type == service.type
                            && instance.domain == service.domain
                            && instance.interfaceIndex == service.interfaceIndex {
                            return true
                        } else {
                            return false
                        }
                    }
                    
                    if !arr.isEmpty {
                        let instance = arr[0]
                        completion(DiscoverDNSService(DNSInstance: instance))
                    } else {
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            }
        }
    }
}
