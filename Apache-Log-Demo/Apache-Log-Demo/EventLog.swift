//
//  EventLog.swift
//  Apache-Log-Demo
//
//  Created by Matthew Kaulfers on 4/12/21.
//

import Foundation

class EventLog: Identifiable {
    let id = UUID()
    let ipAddress: String
    let date: String
    let getMethod: String
    let statusCode: String
    let secondStatusCode: String
    let versionInfo: String
    
    init(ipAddress: String, date: String, getMethod: String, statusCode: String, secondStatusCode: String, versionInfo: String ){
        self.ipAddress = ipAddress
        self.date = date
        self.getMethod = getMethod
        self.statusCode = statusCode
        self.secondStatusCode = secondStatusCode
        self.versionInfo = versionInfo
    }
}
