//
//  ChartTrainingPerDayView.swift
//  NegroniChallenge
//
//  Created by Simon Bestler on 29.10.22.
//

import SwiftUI
import Charts

struct ChartTrainingPerDayView: View {
    
    @EnvironmentObject var vm : MainViewModel
    let goal : GoalEntity
    
    var body: some View {
        
        ZStack {
            Color("cardColor")
            VStack {
                Chart {
                    ForEach(vm.chartData) { exercise in
                        BarMark (
                            x: .value("Day", exercise.day),
                            y: .value("Total Count", exercise.count)
                        )
                        .foregroundStyle(by: .value("Type of training", exercise.trainingType.rawValue))
                    }
                }.onAppear(){
                    vm.getTrainingsPerDay(for: goal)
            }
            }.padding(30)
        }.cornerRadius(20)
            .padding(.bottom, 40)
            .padding(.horizontal, 20)
    }
}


 struct ChartTrainingPerDayView_Previews: PreviewProvider {
 static var previews: some View {
     ChartTrainingPerDayView(goal: GoalEntity())
         .environmentObject(MainViewModel())
 }
 }
 
