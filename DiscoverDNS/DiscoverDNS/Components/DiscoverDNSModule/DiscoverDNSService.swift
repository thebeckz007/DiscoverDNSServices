//
//  DiscoverDNSService.swift
//  DiscoverDNS
//
//  Created by Phan Anh Duy on 09/12/2023.
//

import Foundation
import DNSServiceDiscovery

// MARK: DiscoverDNSService struct
/// DiscoverDNSService struct for using UI layer
struct DiscoverDNSService: Identifiable {
    var id = UUID()
    
    /// The Service name.
    public var name: String
    /// The service type.
    public var type: DNSServiceType
    /// The domain.
    public var domain: Domain
    /// The interface index on which the service was discovered.
    public var interfaceIndex: UInt32
    /// The port on which the instance is running.
    public var port: UInt16? = nil
    /// The TXT record key-value pairs. Only provided during resolution.
    public var txtRecord: [String: String] = [:]
}

extension DiscoverDNSService {
    init(name: String, type: DNSServiceType, domain: Domain, interfaceIndex: UInt32, port: UInt16? = nil, txtRecord: [String : String]) {
        self.name = name
        self.type = type
        self.domain = domain
        self.interfaceIndex = interfaceIndex
        self.port = port
        self.txtRecord = txtRecord
    }
    
    init(DNSInstance: DNSServiceInstance) {
        self.init(
            name: DNSInstance.name,
            type: DNSInstance.type,
            domain: DNSInstance.domain,
            interfaceIndex: DNSInstance.interfaceIndex,
            port: DNSInstance.port,
            txtRecord: DNSInstance.txtRecord
        )
    }
}

extension DiscoverDNSService {
    func convertToDNSServiceQuery() -> DNSServiceQuery {
        return DNSServiceQuery.init(name: self.name, type: self.type, domain: self.domain)
    }
}

extension DiscoverDNSService: Equatable {
    static func == (lhs: DiscoverDNSService, rhs: DiscoverDNSService) -> Bool {
        if lhs.name == rhs.name
            && lhs.type == rhs.type
            && lhs.domain == rhs.domain
            && lhs.interfaceIndex == rhs.interfaceIndex
            && lhs.port == rhs.port
            && lhs.txtRecord == rhs.txtRecord {
            true
        } else {
            false
        }
    }
}
