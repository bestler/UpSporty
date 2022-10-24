//
//  Results.swift
//  Test 25
//
//  Created by 4Func on 19/10/22.
//

import SwiftUI

struct Results: View {
    
    let screenWidth  = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    private var data: [Int] = Array(1...20)
    
    private let numberColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    let numberOfColumns: Int = 3
    
    @State var goalCardAtAll = [
        GoalCardResults(
            sportIcon: "figure.run",
            sportColor: .green,
            sportName: "Running",
            targetIcon: "flag",
            target: 2000,
            targetMeasure: "mt",
            clockIcon: "stopwatch",
            targetTime: Int(2.00),
            targetTimeMeaseure: "mins",
            isCompleted: false,
            yearCompletion: 2022
        ),
        
        GoalCardResults(
            sportIcon: "figure.archery",
            sportColor: .yellow,
            sportName: "Archery",
            targetIcon: "flag",
            target: 130,
            targetMeasure: "pt",
            clockIcon: "stopwatch",
            targetTime: Int(0),
            targetTimeMeaseure: "--",
            isCompleted: false,
            yearCompletion: 2023
        )
    ]
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                Color("mainBackground")
                    .ignoresSafeArea()
                ScrollView {
                    LazyVGrid(columns: numberColumns, spacing: 20){
                        ForEach(goalCardAtAll) { goalCard in
                            ZStack{
                                Rectangle()
                                    .foregroundColor(Color("cardColor"))
                                    .cornerRadius(20)
                                VStack {
                                    Image(systemName: goalCard.sportIcon)
                                        .foregroundColor(goalCard.sportColor)
                                        .font(.system(size: 45))
                                    Text("\(goalCard.sportName)")
                                        .foregroundColor(Color("blackText"))
                                        .font(.system(size: 17, weight: .medium, design: .rounded))
                                    Text("\(goalCard.yearCompletion)")
                                        .foregroundColor(Color("grayText"))
                                        .font(.system(size: 12, weight: .medium, design: .rounded))
                                }
                                Image(systemName: "medal.fill")
                                    .foregroundColor(.green)
                                    .font(.system(size: 20))
                                    .frame(width: screenWidth/CGFloat(numberOfColumns)-41, height: screenWidth/CGFloat(numberOfColumns)-41, alignment: .topTrailing)
                            }
                            .frame(width: screenWidth/CGFloat(numberOfColumns)-21, height: screenWidth/CGFloat(numberOfColumns)-21)
                        }
                    }.padding()
                }
                
            }.navigationTitle("Results")
        }
    }
}

struct Results_Previews: PreviewProvider {
    static var previews: some View {
        Results()
    }
}
