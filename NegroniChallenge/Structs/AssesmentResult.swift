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
}
