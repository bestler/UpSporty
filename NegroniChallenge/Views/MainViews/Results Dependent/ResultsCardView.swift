//
//  ResultsCardView.swift
//  NegroniChallenge
//
//  Created by Nicola Rigoni on 01/11/22.
//

import SwiftUI

struct ResultsCardView: View {
    let goal: GoalEntity
    var sport: SportModel? = nil
    
    init(goal: GoalEntity) {
        self.goal = goal
        if let sport = SportModel.getSport(for: goal.sportID) {
            self.sport = sport
        }
    }
    var body: some View {
        if let sport {
            ZStack(alignment: .topTrailing) {
                VStack(spacing: 5) {
                    Image(systemName: sport.sportIcon)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(sport.sportColor)
                        .frame(height: 30)
                    Text(sport.sportName.rawValue)
                        .font(.headline)
                        .padding(.bottom, 8)
                    HStack {
                        VStack(spacing: 5) {
                            Image(systemName: "stopwatch") 
                            Text(goal.targetTime.asTimeFormatted())
                        }
                        Divider()
                        VStack(spacing: 5) {
                            Image(systemName: "flag")
                            Text("\(String(format: "%.0f", goal.target)) Mt")
                        }
                        
                    }
                    .font(.system(size: 8))
                    .foregroundColor(.secondary)
                    .frame(height: 10)
                }
                Image(systemName: "medal.fill")
                    .foregroundColor(.yellow)
                    .font(.system(size: 20))
                    .padding(.trailing, -5)
                    .padding(.top, -10)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("cardColor"))
                    .frame(width: 105, height: 105)
            )
        }
    }
}

struct ResultsCardView_Previews: PreviewProvider {
    static let manager = CoreDataManager.instance
    static var previews: some View {
        ResultsCardView(goal: GoalEntity(context: manager.context))
    }
}
