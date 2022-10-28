//
//  LinearGraphView.swift
//  NegroniChallenge
//
//  Created by Matteo Fontana on 24/10/22.
//

import SwiftUI

struct LinearGraphView: View {
    
    @State var progress: CGFloat
    @State var progressZero: CGFloat = -10
    @State var colored: Color
    @State private var numberGraph: Double = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Goal path percentage:")
                    .foregroundColor(Color("grayText"))
                Text(" ")
                    .frame(width: 35, height: 20)
                    .modifier(AnimatableNumberModifier(number: numberGraph))
                    .bold()
                    .foregroundColor(Color("grayText"))
                Text("%")
                    .foregroundColor(Color("grayText"))
            }
            ProgressBarLinear(progress: numberGraph, color: colored)
            .onAppear() {
                withAnimation(.spring(response: 0.8, dampingFraction: 0.9, blendDuration:100)) {
                    progressZero = progress
                    numberGraph = progress + 0
                }
            }
        }
    }
}

struct LinearGraph_Previews: PreviewProvider {
    static var previews: some View {
        LinearGraphView(progress: 71, progressZero: -10, colored: Color.red)
    }
}
