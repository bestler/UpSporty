//
//  SwiftUIView.swift
//  Test 25
//
//  Created by Matteo Fontana on 21/10/22.
//

import SwiftUI

struct GoalCardResults: Identifiable {
    let id = UUID()
    
    var sportIcon: String
    var sportColor: Color
    var sportName: String
    var targetIcon: String
    var target: Int
    var targetMeasure: String
    var clockIcon: String
    var targetTime: Int
    var targetTimeMeaseure: String
    var chevronIcon = "chevron.forward"
    
    var isCompleted: Bool
    
    var yearCompletion: Int
}

