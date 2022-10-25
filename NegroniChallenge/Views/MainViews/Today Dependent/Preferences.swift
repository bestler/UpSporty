//
//  Preferences.swift
//  Test 25
//
//  Created by Matteo Fontana on 22/10/22.
//

import SwiftUI

struct Preferences: View {
    
    @Binding var showingSheet: Bool
    
    @AppStorage("selectedAppearance") var selectedAppearance = 0
    @State var utilities = Utilities()
    
    var body: some View {
        NavigationStack{
            ZStack {
                VStack {
                    Spacer()
                    Button(action: {
                        selectedAppearance = 1
                    }) {
                        Text("Light")
                    }
                    Spacer()
                    Button(action: {
                        selectedAppearance = 2
                    }) {
                        Text("Dark")
                    }
                    Spacer()
                    Button(action: {
                        selectedAppearance = 0
                    }) {
                        Text("System")
                    }
                    Spacer()
                }
                .onChange(of: selectedAppearance, perform: { value in
                    utilities.overrideDisplayMode()
                })
            }
            .navigationBarTitle(Text("Preferences"), displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button{
                self.showingSheet.toggle()
            } label: {
                Text("Done")
                    .bold()
            })
        }
    }
}
