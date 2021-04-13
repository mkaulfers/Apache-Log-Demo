//
//  EventLog.swift
//  Apache-Log-Demo
//
//  Created by Matthew Kaulfers on 4/12/21.
//

import Foundation

struct EventLog: Identifiable, Hashable  {
    let id: UUID = UUID()
    let ipAddress: String
    let date: String
    let getMethod: String
    let statusCode: String
    let secondStatusCode: String
    let versionInfo: String
}
