//
//  ErrorModal.swift
//  Apache-Log-Demo
//
//  Created by Matthew Kaulfers on 4/12/21.
//

import SwiftUI

struct LandingPageErrorModal: View {
    @ObservedObject var landingPageVM: LandingPageViewModel
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .center, spacing: 30) {
                Spacer()
                Text("Error:").font(.headline)
                Text(landingPageVM.errorMessage).multilineTextAlignment(.center)
                Button("Close", action: {
                    landingPageVM.activeSheet = nil
                })
                Spacer()
            }
        }.padding(.horizontal, 30)
        .background(BackgroundBlurView())
        .edgesIgnoringSafeArea(.all)
    }
}
