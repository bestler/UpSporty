//
//  GoalCardView.swift
//  NegroniChallenge
//
//  Created by Matteo Fontana on 25/10/22.
//

import SwiftUI

struct GoalCardView: View {
    //@EnvironmentObject var vm: MainViewModel
    let screenWidth  = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    let goal: GoalEntity
    var sport: SportModel? = nil
    
    init(goal: GoalEntity) {
        self.goal = goal
        if let sport = SportModel.getSport(for: goal.sportID) {
            self.sport = sport
        }
    }
    
    
    
    var body: some View {
        HStack(spacing: 0){
            if let sport = sport {
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
                        Text("\(goal.target)")
                            .font(.system(size: 23))
                    }
                    HStack{
                        Image(systemName: "stopwatch")
                            .font(.system(size: 28))
                            .fontWeight(.bold)
                            .foregroundColor(Color("grayText"))
                        Text("\(goal.targetTime)")
                            .font(.system(size: 23))
                    }
                }
                .padding(.leading, 20)
                Spacer()
                Image(systemName: "chevron.forward")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .foregroundColor(Color("grayText"))
            }
            
        }
    }
}
struct GoalCardView_Previews: PreviewProvider {
    static var previews: some View {
        GoalCardView(goal: GoalEntity())
    }
}
