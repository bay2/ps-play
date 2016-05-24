//
//  SharedPoint.swift
//  SharingBrowser
//
//  Created by Peter Wood on 20.08.14.
//
//

import Foundation

class SharedPoint:Equatable {
    var netService:NSNetService
    var type:String
    var ipAddress:String
    
    init(netService:NSNetService, type:String, ipAddress:String) {
        self.netService = netService
        self.type = type
        self.ipAddress = ipAddress
    }
}

func == (lhs: SharedPoint, rhs: SharedPoint) -> Bool {
    return (lhs.netService == rhs.netService) && (lhs.type == rhs.type) && (lhs.ipAddress == rhs.ipAddress)
}