//
//  TrainingResultView.swift
//  NegroniChallenge
//
//  Created by Nicola Rigoni on 26/10/22.
//

import SwiftUI

struct TrainingResultView: View {
    @EnvironmentObject var vm: MainViewModel
    let training: TrainingEntity
    var body: some View {
        ZStack {
                Color("mainBackground")
                    .ignoresSafeArea()
            List {
                ForEach(vm.currentResultTraining) { result in
                    Section {
                        TrainingResultRowView(result: result)
                    } header: {
                        Text("\(result.number)/\(training.repeatCountTotal)")
                    }
                    
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .navigationBarTitle(Text("Exercise title"), displayMode: .inline) //\(detail.sportName)
            .navigationBarItems(trailing:
                    Button(action: {
                
            }) {
                Text("Edit").bold()
            }
            )
            .onAppear {
                vm.getResult(for: training)
            }
        }
        
    }
}

struct TrainingResultView_Previews: PreviewProvider {
    static let manager = CoreDataManager.instance
    static var previews: some View {
        NavigationStack {
            TrainingResultView(training: TrainingEntity(context: manager.context))
                .environmentObject(MainViewModel())
        }
        
    }
}
