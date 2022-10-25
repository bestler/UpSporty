//
//  SwiftUIView.swift
//  NegroniChallenge
//
//  Created by Matteo Fontana on 24/10/22.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
struct ProgressBarLinear: View{
    var progress: CGFloat = 50
    var color: Color = Color.red
    
    var body: some View{
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray)
                .frame(width: 300,
                       height: 10)
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
                .frame(width: 300 * progress / 100,
                       height: 10)
        }
    }
}
