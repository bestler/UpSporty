//
//  GoalCardView.swift
//  NegroniChallenge
//
//  Created by Matteo Fontana on 25/10/22.
//

import SwiftUI

struct GoalCardView: View {
    @EnvironmentObject var vm: MainViewModel
    let screenWidth  = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var goalCardInstance: GoalCard
    
    var body: some View {
        HStack(spacing: 0){
            Image(systemName: goalCardInstance.sportIcon)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 64, height: 40, alignment: .leading)
                .foregroundColor(goalCardInstance.sportColor)
            VStack(alignment: .leading, spacing: 10){
                Text(goalCardInstance.sportName)
                    .font(.system(size: 28))
                    .foregroundColor(Color("blackText"))
                    .fontWeight(.bold)
                    .padding(.leading, 3)
                HStack{
                    Image(systemName: goalCardInstance.targetIcon)
                        .font(.system(size: 28))
                        .fontWeight(.bold)
                        .foregroundColor(Color("grayText"))
                    Text("\(goalCardInstance.target) \(goalCardInstance.targetMeasure)")
                        .font(.system(size: 23))
                }
                HStack{
                    Image(systemName: goalCardInstance.clockIcon)
                        .font(.system(size: 28))
                        .fontWeight(.bold)
                        .foregroundColor(Color("grayText"))
                    Text("\(goalCardInstance.targetTime) \(goalCardInstance.targetTimeMeaseure)")
                        .font(.system(size: 23))
                }
            }
            .padding(.leading, 20)
            Spacer()
            Image(systemName: goalCardInstance.chevronIcon)
                .font(.system(size: 24))
                .fontWeight(.bold)
                .foregroundColor(Color("grayText"))
        }
    }
}
struct GoalCardView_Previews: PreviewProvider {
    static var previews: some View {
        GoalCardView( goalCardInstance: GoalCard(
            sportIcon: "figure.run",
            sportColor: .green,
            sportName: "Running",
            targetIcon: "flag",
            clockIcon: "stopwatch", target: 2000,
            targetMeasure: "mt",
            targetTime: Int(2.00),
            targetTimeMeaseure: "mins",
            isCompleted: false,
            yearCompletion: 0,
            progress: 71
        ))
    }
}
