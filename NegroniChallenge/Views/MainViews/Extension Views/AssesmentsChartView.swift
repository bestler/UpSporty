//
//  AssesmentsChartView.swift
//  NegroniChallenge
//
//  Created by Simon Bestler on 31.10.22.
//

import SwiftUI
import Charts

struct AssesmentsChartView: View {
    
    var performanceChartData : [AssesmentResult]
    
    var body: some View {
        ZStack {
            Color("cardColor")
            if performanceChartData.count > 0 {
                Chart{
                    ForEach(performanceChartData) { assesment in
                        LineMark(x: .value("Date", assesment.date), y: .value("Result", assesment.resultsInMinutes))
                    }
                    
                    ForEach(performanceChartData) { assesment in
                        PointMark(x: .value("Date", assesment.date), y: .value("Result", assesment.resultsInMinutes))
                    
                    }
                     
                    RuleMark(y: .value("Target", performanceChartData[0].goalInMinutes))
                        .foregroundStyle(.red)
                }
                .chartYAxisLabel("Result in minutes")
                .padding(30)
            } else {
                Text("Create an assesment to evaluate your current training level!")
                    .multilineTextAlignment(.center)
                    .padding(20)
            }
        }.cornerRadius(20)
           .padding(.bottom, 40)
           .padding(.horizontal, 20)
    }
}

struct AssesmentsChartView_Previews: PreviewProvider {
    static var previews: some View {
        AssesmentsChartView(performanceChartData: [AssesmentResult(date: Date(), result: 100, goal: 200)])
    }
}
