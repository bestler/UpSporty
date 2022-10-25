//
//  ContentView.swift
//  NegroniChallenge
//
//  Created by Simon Bestler on 24.10.22.
//

import SwiftUI

class Utilities {

    @AppStorage("selectedAppearance") var selectedAppearance = 0
    var userInterfaceStyle: ColorScheme? = .dark

    func overrideDisplayMode() {
        var userInterfaceStyle: UIUserInterfaceStyle

        if selectedAppearance == 2 {
            userInterfaceStyle = .dark
        } else if selectedAppearance == 1 {
            userInterfaceStyle = .light
        } else {
            userInterfaceStyle = .unspecified
        }
        UIApplication.shared.currentUIWindow()?.overrideUserInterfaceStyle = userInterfaceStyle
    }
}

struct ContentView: View {
    
    @EnvironmentObject var vm: MainViewModel
    
    init(){
        updateNaviationBarColor()
    }
    
    var body: some View {
        TabView {
            Today()
                .tabItem {
                    Image(systemName: "calendar.day.timeline.leading")
                    Text("Today")
                }
                .environmentObject(vm)
            Goals()
                .tabItem {
                    Image(systemName: "target")
                    Text("Goals")
                }
                .environmentObject(vm)
            Results()
                .tabItem {
                    Image(systemName: "medal.fill")
                    Text("Results")
                }
                .environmentObject(vm)
        }
        .accentColor(Color("accentTab"))
        .onAppear(){
            let appearance = UITabBar.appearance()
            
            //appearance.isTranslucent = true
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
        ContentView()
    }
}
