//
//  TrainingSheetView.swift
//  NegroniChallenge
//
//  Created by Simon Bestler on 27.10.22.
//

import SwiftUI

struct TrainingSheetView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        NavigationStack {
            EditTrainingSheetView()
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
                            //TODO: Save Trainings to Database
                        }
                    }
                }
        }
        
    }
}

struct TrainingSheetView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingSheetView()
    }
}
