//
//  Sports.swift
//  Test 25
//
//  Created by Matteo Fontana on 21/10/22.
//

import SwiftUI

enum SportsName: String {
    case running = "Running"
    case swimming = "Swimming"
}

struct SportModel: Identifiable{
    let id: Int
    var sportIcon: String {
        switch sportName {
        case .running:
            return "figure.run"
        case .swimming:
            return "figure.pool.swim"
        }
    }
    let sportName: SportsName
    var sportColor: Color {
        switch sportName {
        case .running:
            return .green
        case .swimming:
            return .cyan
        }
        
    }
    
    static var allSports: [SportModel] { [
        SportModel(id: 1, sportName: .running),
        SportModel(id: 2, sportName: .swimming)
        ]
    }
    
    static func getSport(for index: Int16) -> SportModel? {
        if let index = allSports.firstIndex(where: { $0.id == index }) {
            return allSports[index]
        }
        return nil
    }
}
