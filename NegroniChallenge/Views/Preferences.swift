//
//  Preferences.swift
//  Test 25
//
//  Created by Matteo Fontana on 22/10/22.
//

import SwiftUI

struct Preferences: View {
    
    @Binding var showingSheet: Bool
    
    var body: some View {
        NavigationStack{
            ZStack{
                
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
