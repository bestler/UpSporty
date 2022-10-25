//
//  MainViewModel.swift
//  NegroniChallenge
//
//  Created by Nicola Rigoni on 25/10/22.
//

import Foundation

class MainViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    
    @Published var test: String = "Connected"
    
    @Published var allSports: [SportModel] = SportModel.allSports
    
}
