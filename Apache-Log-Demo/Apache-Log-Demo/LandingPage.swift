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
        ScrollView {
            LazyVStack {
                ForEach(landingPageVM.eventLogs, id: \.self) { logs in
                    Section(header: HeaderView(sectionTitle: logs.count.description).frame(width: 150, height: 50).shadow(radius: 7)) {
                        ForEach(logs) { log in
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
                    }
                }
                
            }.onAppear {
                landingPageVM.fetchRemoteData()
            }.fullScreenCover(item: $landingPageVM.activeSheet) { item in
                switch item {
                case .loading:
                    ApacheProgressIndicator()
                case .error:
                    LandingPageErrorModal(landingPageVM: landingPageVM)
                }
        }
        }
    }
}

struct HeaderView: View {
    var sectionTitle = ""
    var body: some View {
        RoundedRectangle(cornerRadius: 50).foregroundColor(.green).overlay(
            Text("Sequence: \(sectionTitle)")
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPage()
    }
}
