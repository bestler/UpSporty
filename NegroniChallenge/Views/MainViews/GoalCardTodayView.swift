//
//  GoalCardTodayView.swift
//  NegroniChallenge
//
//  Created by Nicola Rigoni on 28/10/22.
//

import SwiftUI

struct GoalCardTodayView: View {
    @EnvironmentObject var vm: MainViewModel
    let screenWidth  = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    @State var progressZero: CGFloat = -10
    @State private var numberGraph: Double = 0
    
    var sport: SportModel? = nil
    
    init() {
        if let selectedToday = vm.selectedToday {
            if let sport = SportModel.getSport(for: selectedToday.sportID) {
                self.sport = sport
            }
        }
    }
    
    var body: some View {
        if let sport, let selectedToday = vm.selectedToday {
                VStack{
                    HStack(spacing: 0){
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
                                Text("\(selectedToday.target)") //\(sport.targetMeasure)
                                    .font(.system(size: 23))
                            }
                            HStack{
                                Image(systemName: "stopwatch")
                                    .font(.system(size: 28))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("grayText"))
                                Text("\(selectedToday.targetTime)") //\(sport.targetTimeMeaseure)
                                    .font(.system(size: 23))
                            }
                        }
                        .padding(.leading, 20)
                        Spacer()
                    }
                    VStack(alignment: .leading) {
                        LinearGraphView(progress: 30, colored: sport.sportColor) //goalCardInstance.progress
                        .onAppear() {
                            withAnimation(.spring(response: 0.8, dampingFraction: 0.9, blendDuration:100)) {
                              //  progressZero = goalCardInstance.progress
                              //  numberGraph = goalCardInstance.progress + 0
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
        }
}

struct GoalCardTodayView_Previews: PreviewProvider {
    static var previews: some View {
        GoalCardTodayView()
            .environmentObject(MainViewModel())
    }
}
