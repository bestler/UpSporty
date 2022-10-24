//
//  CircularGraphFunctions.swift
//  Test 25
//
//  Created by Matteo Fontana on 21/10/22.
//

import SwiftUI

struct CircularGraphFunctions: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CircularGraphFunctions_Previews: PreviewProvider {
    static var previews: some View {
        CircularGraphFunctions()
    }
}

struct Label: View {
    var progress: CGFloat = 0
    var body: some View{
        ZStack{
            Text(String(format: "%.0f", progress))
        }
    }
}
struct ProgressBar: View{
    var progress: CGFloat = 50
    var color: Color = Color.red
    
    var body: some View{
        ZStack{
            Circle()
                .trim(from: 0.0, to: CGFloat(0.75))
                .stroke(style: StrokeStyle(lineWidth: 35.0, lineCap: .round, lineJoin: .round))
                .opacity(0.20)
                .foregroundColor(Color.gray)
                .rotationEffect(Angle(degrees: 135))
            
            Circle()
                .trim(from: 0.0, to: progress * 0.75 * 0.01)
                .stroke(style: StrokeStyle(lineWidth: 35.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 135))
                //.animation(.easeInOut(duration: 2), value: 1)
                //.animation(.spring(response: 2.0, dampingFraction: 1.0, blendDuration: 1.0), value: progress)
        }
    }
}
struct AnimatableNumberModifier: AnimatableModifier {
    var number: Double
    
    var animatableData: Double {
        get { number }
        set { number = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Text("\(Int(number))")
            )
    }
}
