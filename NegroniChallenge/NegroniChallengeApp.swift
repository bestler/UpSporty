//
//  NegroniChallengeApp.swift
//  NegroniChallenge
//
//  Created by Simon Bestler on 24.10.22.
//

import SwiftUI

@main
struct NegroniChallengeApp: App {
    @StateObject var vm: MainViewModel = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
        }
    }
}
