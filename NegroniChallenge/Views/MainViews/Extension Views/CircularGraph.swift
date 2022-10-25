//
//  SwiftUIView.swift
//  Test 25
//
//  Created by Matteo Fontana on 21/10/22.
//

import SwiftUI

struct CircularGraph: View {
    
    //Var for the Circular Graph
    @State var progress: CGFloat
    @State var progressZero: CGFloat = -10
    @State var colored: Color
    @State private var numberGraph: Double = 0
    
    var body: some View {
        VStack {
            
            Text("Days")
            
            //ZStack Circular Graph
            ZStack{
                VStack{
                    HStack(alignment: .firstTextBaseline){
                        Text(" ")
                            .frame(width: 80, height: 50)
                            .modifier(AnimatableNumberModifier(number: numberGraph))
                            .font(.system(size: 60))
                            .fontWeight(.bold)
                        Text("%")
                            .font(.system(size: 24) .weight(.bold))
                            .baselineOffset(60 - 36)
                            .padding(.leading, -10)
                    }
                    Text("of your goal path")
                        .font(.system(size: 18) .weight(.bold))
                }
                ProgressBar(progress: numberGraph, color: colored)
                    .frame(width: 260.0, height: 260.0)
                    .padding(20.0).onAppear(){
                }
            }
            .onAppear() {
                withAnimation(.spring(response: 0.8, dampingFraction: 0.9, blendDuration:100)) {
                    progressZero = progress
                    numberGraph = progress + 0
                }
            }
        }
    }
}

struct CircularGraph_Previews: PreviewProvider {
    static var previews: some View {
        CircularGraph(progress: 71, progressZero: -10, colored: Color.red)
    }
}
