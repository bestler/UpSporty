//
//  TabBarView.swift
//  NegroniChallenge
//
//  Created by Simon Bestler on 24.10.22.
//

import SwiftUI

struct TabBarView: View {
    
    @EnvironmentObject var vm: MainViewModel
    
    init(){
        updateNaviationBarColor()
    }
    
    var body: some View {
        TabView {
            TodayView()
                .environmentObject(vm)
                .tabItem {
                    Image(systemName: "calendar.day.timeline.leading")
                    Text("Today")
                }
            GoalsView()
                .tabItem {
                    Image(systemName: "target")
                    Text("Goals")
                }
                .environmentObject(vm)
            ResultsView()
                .tabItem {
                    Image(systemName: "medal.fill")
                    Text("Results")
                }
                .environmentObject(vm)
        }
        .accentColor(Color("accentTab"))
        .onAppear(){
            let appearance = UITabBar.appearance()
            appearance.unselectedItemTintColor = UIColor(Color.gray)
            appearance.backgroundColor = UIColor(Color("mainBackground"))
        }
    }
    
    func updateNaviationBarColor(){
        UINavigationBar.appearance().barTintColor = UIColor(Color("mainBackground"))
        UINavigationBar.appearance().backgroundColor = UIColor(Color("mainBackground"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
            .environmentObject(MainViewModel())
    }
}
