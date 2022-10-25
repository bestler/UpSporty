//
//  GoalCard.swift
//  Test 25
//
//  Created by Matteo Fontana on 19/10/22.
//

import SwiftUI

struct GoalCard: Identifiable {
    let id = UUID()
    
    //sport
    var sportIcon: String
    var sportColor: Color
    var sportName: String
    var targetIcon: String
    var clockIcon: String
    
    //goal
    var target: Int //Double
    var targetMeasure: String //not need formatter instead
    var targetTime: Int
    var targetTimeMeaseure: String //not need formatter instead
    var isCompleted: Bool
    var yearCompletion: Int //Date
    //not needed
    var progress: CGFloat //Double
    
    //not needed
    var chevronIcon = "chevron.forward"
    
    
  
}
