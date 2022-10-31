//
//  TrainingsPerDay.swift
//  NegroniChallenge
//
//  Created by Simon Bestler on 29.10.22.
//

import Foundation

struct TrainingsPerDay : Identifiable{
    
    let id : UUID = UUID()
    let day : String
    var count : Int = 0
    var trainingType : TrainingType

}
