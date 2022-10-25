//
//  DetailView.swift
//  Test 25
//
//  Created by Matteo Fontana on 20/10/22.
//

import SwiftUI

struct DetailView: View {
    
    var detail: GoalCard
    
    let screenWidth  = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        
        NavigationStack{
            ZStack {
                Color("mainBackground")
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    TabView {
                        CircularGraph(progress: detail.progress, colored: detail.sportColor)
                        Text("Second")
                        Text("Third")
                        Text("Fourth")
                    }
                    .frame(width: screenWidth, height: screenWidth)
                    .tabViewStyle(.page)
                    .onAppear {
                        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color("blackText"))
                        UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color("blackText")).withAlphaComponent(0.2)
                    }
                    Spacer()
                    Text("\(detail.sportName)")
                        .font(.system(size: 20))
                    
                }
            }
            .navigationBarTitle(Text("\(detail.sportName)"), displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                
                }) {
                    Text("Edit").bold()
                }
            )
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(detail: GoalCard(
            sportIcon: "figure.run",
            sportColor: .green,
            sportName: "Running",
            targetIcon: "flag",
            clockIcon: "stopwatch", target: 2000,
            targetMeasure: "mt",
            targetTime: Int(2.00),
            targetTimeMeaseure: "min",
            isCompleted: false,
            yearCompletion: 0,
            progress: 71
        ))
    }
}
