//
//  TrainingSheetView.swift
//  NegroniChallenge
//
//  Created by Simon Bestler on 27.10.22.
//

import SwiftUI

struct TrainingSheetView: View {
    @EnvironmentObject var vm: MainViewModel
    @Environment(\.dismiss) private var dismiss
    let goal: GoalEntity
    
    var body: some View {
        
        NavigationStack {
            EditTrainingSheetView()
                .environmentObject(vm)
                .navigationTitle("Training Sheet")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .cancellationAction){
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .confirmationAction){
                        Button("Save"){
                            vm.saveTraining(selectedGoal: goal)
                            dismiss()
                        }
                    }
                }
        }
        
    }
}

struct TrainingSheetView_Previews: PreviewProvider {
    static let manager = CoreDataManager.instance
    static var previews: some View {
        TrainingSheetView(goal: GoalEntity(context: manager.context))
            .environmentObject(MainViewModel())
    }
}
