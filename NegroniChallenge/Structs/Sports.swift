//
//  Sports.swift
//  Test 25
//
//  Created by Matteo Fontana on 21/10/22.
//

import SwiftUI

struct Sport: Identifiable{
    let id = UUID()
    
    var sportIcon: String
    var sportName: String
    var sportColor: Color
    var isSelected: Bool
}
