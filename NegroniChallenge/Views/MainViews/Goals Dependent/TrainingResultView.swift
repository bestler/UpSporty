//
//  TrainingResultView.swift
//  NegroniChallenge
//
//  Created by Nicola Rigoni on 26/10/22.
//

import SwiftUI

struct TrainingResultView: View {
    @State private var count: Int = 1
    @State private var elementArray: [Int] = [1,2,3]
    var body: some View {
        VStack {
            List {
                ForEach(Array(elementArray.enumerated()), id: \.element) { index, item in
                    Section {
                        TrainingResultRowView()
                    } header: {
                        Text("\(index)/5")
                    }
                    
                }
            }
            .listStyle(.insetGrouped)
            .navigationBarTitle(Text("Exercise title"), displayMode: .inline) //\(detail.sportName)
            .navigationBarItems(trailing:
                    Button(action: {
                
            }) {
                Text("Edit").bold()
            }
            )
        }
        
    }
}

struct TrainingResultView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TrainingResultView()
        }
        
    }
}
