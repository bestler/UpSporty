//
//  AssesmentResult.swift
//  NegroniChallenge
//
//  Created by Simon Bestler on 31.10.22.
//

import Foundation

struct AssesmentResult : Identifiable {
    let id = UUID()
    let date : Date
    let result : Int64
    let goal : Int64
    var resultsInMinutes : Double {return Double(result)/(1000.0*60.0)}
    var goalInMinutes : Double {return Double(goal)/(1000.0*60.0)}
}
