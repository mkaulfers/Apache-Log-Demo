//
//  ContentView.swift
//  Apache-Log-Demo
//
//  Created by Matthew Kaulfers on 4/12/21.
//

import SwiftUI

struct LandingPage: View {
    @ObservedObject var landingPageVM = LandingPageViewModel()
    var body: some View {
        List {
            
            ForEach(landingPageVM.eventLogs) { log in
                ZStack {
                    RoundedRectangle(cornerRadius: 30).frame(height: 200).foregroundColor(.white).shadow(radius: 7).overlay(
                        HStack {
                            VStack(alignment: .leading, spacing: 5){
                                Spacer()
                                Text("IP Address: " + log.ipAddress).font(.system(size: 8))
                                Text("Date: " + log.date).font(.system(size: 8))
                                Text("Get Method: " + log.getMethod).font(.system(size: 8))
                                Text("Status: " + log.statusCode).font(.system(size: 8))
                                Text("Secondary Status: " + log.secondStatusCode).font(.system(size: 8))
                                Text("Version Info").font(.system(size: 8))
                                Text(log.versionInfo).lineLimit(2).fixedSize(horizontal: false, vertical: true).font(.system(size: 8))
                                Spacer()
                            }
                            Spacer()
                        }.padding())
                }.padding()
            }
        }.onAppear {
            landingPageVM.fetchRemoteData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPage()
    }
}
