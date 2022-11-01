//
//  SwiftUIView.swift
//  Test 25
//
//  Created by Matteo Fontana on 21/10/22.
//

import SwiftUI

struct CircularGraphView: View {
    
    //Var for the Circular Graph
    @State var progress: CGFloat
    @State var progressZero: CGFloat = -10
    @State var colored: Color
    @State private var numberGraph: Double = 0
    let totalDays: Int
    let completedDays: Int

    
    var body: some View {
        VStack {
            
            Text("Progress of challenge")
            
            //ZStack Circular Graph
            ZStack{
                VStack{
                    HStack(alignment: .firstTextBaseline){
                        Text(" ")
                            .frame(width: 80, height: 50)
                            .modifier(AnimatableNumberModifier(number: numberGraph))
                            .font(.system(size: 60))
                            .fontWeight(.bold)
                            
                        
                        Text("/ \(totalDays) days")
                            .font(.system(size: 24) .weight(.bold))
                            .baselineOffset(60 - 36)
                            .padding(.leading, totalDays > 9 ? -10 : -20)
                    }
                    Text("of challenge passed")
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
        CircularGraphView(progress: 71, progressZero: -10, colored: Color.red, totalDays: 90, completedDays: 9)
    }
}
