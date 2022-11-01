//
//  GoalCardTodayView.swift
//  NegroniChallenge
//
//  Created by Nicola Rigoni on 28/10/22.
//

import SwiftUI

struct GoalCardTodayView: View {
    let screenWidth  = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    let progress: CGFloat
    @State var progressZero: CGFloat = -10
    @State private var numberGraph: Double = 0
    
    let goal: GoalEntity
    var sport: SportModel? = nil
    
    init(goal: GoalEntity, progress : CGFloat) {
        self.goal = goal
        if let sport = SportModel.getSport(for: goal.sportID) {
            self.sport = sport
        }
        self.progress = progress
    }
    
    var body: some View {
        if let sport {
            VStack(alignment: .leading){
            HStack(spacing: 0) {
                Image(systemName: sport.sportIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 64, height: 40, alignment: .leading)
                    .foregroundColor(sport.sportColor)
                VStack(alignment: .leading, spacing: 10){
                    Text(sport.sportName.rawValue)
                        .font(.system(size: 28))
                        .foregroundColor(Color("blackText"))
                        .fontWeight(.bold)
                        .padding(.leading, 3)
                    HStack{
                        Image(systemName: "flag")
                            .font(.system(size: 28))
                            .fontWeight(.bold)
                            .foregroundColor(Color("grayText"))
                        Text("\(String(format: "%.0f", goal.target)) Mt")
                            .font(.system(size: 23))
                    }
                    HStack{
                        Image(systemName: "stopwatch")
                            .font(.system(size: 28))
                            .fontWeight(.bold)
                            .foregroundColor(Color("grayText"))
                        Text("\(goal.targetTime.asTimeFormatted())") //\(sport.targetTimeMeaseure)
                            .font(.system(size: 23))
                    }
                }
                .padding(.leading, 20)
                Spacer()
            }
            VStack {
                LinearGraphView(daysLeft : (Calendar.current.numberOfDaysBetween(Date(), and: goal.dueDate!)), progress: progress, colored: sport.sportColor)
                    .onAppear() {
                        withAnimation(.spring(response: 0.8, dampingFraction: 0.9, blendDuration:100)) {
                              progressZero = progress
                              numberGraph = progress + 0
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                //Text("Days left: \(Calendar.current.numberOfDaysBetween(Date(), and: goal.dueDate!))")
            }
        }
    }
    }
}

struct GoalCardTodayView_Previews: PreviewProvider {
    static let manager = CoreDataManager.instance
    static var previews: some View {
        GoalCardTodayView(goal: GoalEntity(context: manager.context), progress: 85)
    }
}
