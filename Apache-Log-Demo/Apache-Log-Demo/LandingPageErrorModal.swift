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
                Text("Please wait while we create a new file.")
                Spacer()
            }
            Spacer()
        }.padding(.horizontal, 30)
        .background(BackgroundBlurView())
        .edgesIgnoringSafeArea(.all)
    }
}

struct LandingPageErrorModal_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageErrorModal(landingPageVM: LandingPageViewModel())
    }
}
