//
//  DNSServicetype+.swift
//  DiscoverDNS
//
//  Created by Phan Anh Duy on 09/12/2023.
//

import Foundation
import DNSServiceDiscovery

extension DNSServiceType {
    /// printer
    public static let printer: Self = "_printer._tcp"
    
    /// Companion
    public static let companionLink: Self = "_companion-link._tcp"
    
    /// Spotify
    public static let spotify: Self = "_spotify-connect._tcp"
    
    /// data stream
    public static let pdlDataStream: Self = "_pdl-datastream._tcp"
}

extension DNSServiceType {
    func fullDescription() -> String {
        var result: String
        
        switch self.relative {
        case .printer:
            result = "Printer Protocol"
        case .companionLink:
            result = "Companion Link Protocol"
        case .spotify:
            result = "Spotify Protocol"
        case .pdlDataStream:
            result = "PDL Data Stream Protocol"
        case .airplay:
            result = "Airplay Protocol"
        case .homeSharing:
            result = "Home Sharing Protocol"
        case .http:
            result = "HTTP (Hypertext Transfer Protocol)"
        case .raop:
            result = "Remote Audio Output Protocol"
        case .ssh:
            result = "Secure Shell Protocol"
        default:
            result = "Other Protocol"
        }
        
        return result
    }
}
