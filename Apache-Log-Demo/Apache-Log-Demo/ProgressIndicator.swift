//
//  ProgressIndicator.swift
//  Apache-Log-Demo
//
//  Created by Matthew Kaulfers on 4/12/21.
//

import SwiftUI

struct ApacheProgressIndicator: View {
    var body: some View {
        ZStack {
            BackgroundBlurView().edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                ProgressIndicator()
                Text("Loading...")
            }.padding(.vertical, 30)
        }.animation(.easeInOut)
    }
}

struct ProgressIndicator: View {
    @Environment(\.colorScheme) var colorScheme
    @State var isAnimating = false
    var numOfCircles = 10
    
    @State var totalAngle:Double = 0
    var body: some View {
        
        ZStack{
            ForEach(0..<numOfCircles) { i in
                VStack{
                    Circle()
                        .fill(Color.blue)
                        .frame(width:10, height:10)
                        .shadow(radius: 5)
                    Spacer()
                }.frame(width:100, height:100)
                .opacity(1 - (Double(i)/Double(self.numOfCircles)))
                .rotationEffect(Angle(degrees: self.isAnimating ? 360.0 : 0.0))
                .animation(self.foreverAnimation(Double(i)))
                .onAppear {
                    self.isAnimating = true
                }
            }
        }
        .rotationEffect(Angle(degrees: self.totalAngle))
        .animation(
            .easeInOut(duration: 1)
        )
        .onAppear(){
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                self.totalAngle += 60
            }
        }
        
    }
    
    func foreverAnimation(_ thisDelay:Double = 0) -> Animation{
        return Animation.easeInOut(duration: thisDelay)
            .repeatForever(autoreverses: false)
            .delay(thisDelay/50)
    }
}

struct BackgroundBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct ApacheProgressIndicator_Preview: PreviewProvider {
    static var previews: some View {
        ProgressIndicator().preferredColorScheme(.dark)
    }
}
