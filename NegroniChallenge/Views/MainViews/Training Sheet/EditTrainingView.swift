//
//  CreateExerciseView.swift
//  NegroniChallenge
//
//  Created by Simon Bestler on 26.10.22.
//

import SwiftUI

struct EditTrainingView: View {
    @EnvironmentObject var vm: MainViewModel
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color("mainBackground")
                    .ignoresSafeArea()
                    //TODO: Maybe change to only title in Navbar?? or sth. like this:
                //.navigationTitle(isExercise ? "Exercise" : "Assesment")
                    .navigationTitle("New Training")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar{
                        ToolbarItem(placement: .cancellationAction){
                            Button("Cancel") {
                                dismiss()
                                dismiss()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction){
                            if(vm.trainingType == .exercise){
                                NavigationLink("Next"){
                                    DetailTrainingView()
                                        .environmentObject(vm)
                                }
                            }else{
                                Button("Save"){
                                    vm.updateTrainingFromSheet()
                                    vm.saveNewTrainingStep()
                                    //TODO: CHECK IF ALERT
                                    dismiss()
                                    dismiss()
                                }
                            }
                        }
                    }
                VStack{
                    Text("Create a new Training")
                        .foregroundColor(Color("blackText"))
                        .font(.system(size: 26))
                        .padding(.top, 15)
                        .bold()
                    Text("You can choose between a casual exercise or an assesment")
                        .foregroundColor(Color("blackText"))
                        .padding(.top, 1)
                        .font(.system(size: 18))
                        .padding(.bottom, 20)
                        .multilineTextAlignment(.center)
                    VStack(alignment: .leading){
                        Text("Set the type of training")
                            .foregroundColor(Color("grayText"))
                            .font(.system(size: 14))
                            .bold()
                        HStack {
                            Image(systemName: "list.bullet")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                            Text("Type of training")
                            Spacer()
                            Picker(selection: $vm.trainingType, label: Text("Select for type of training")) {
                                Text("Exercise").tag(TrainingType.exercise)
                                Text("Assesment").tag(TrainingType.assestment)
                            }
                            
                        }
                        .padding(20)
                        .background(Color("cardColor"))
                        .cornerRadius(20)
                        //TODO: Provide a description of what the difference is
                    }.padding(.bottom, 20).padding(.horizontal, 20)
                    VStack(alignment: .leading){
                        Text("Set the date of the training")
                            .foregroundColor(Color("grayText"))
                            .font(.system(size: 14))
                            .bold()
                        HStack {
                            Image(systemName: "calendar")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                            DatePicker(
                                "Training Date",
                                selection: $vm.trainingDueDate,
                                displayedComponents: [.date]
                            )
                        }
                        .padding(20)
                        .background(Color("cardColor"))
                        .cornerRadius(20)
                        Spacer()
                    }.padding(.horizontal, 20)
                }
                
            }
        }
        
    }
}

struct EditTrainingView_Previews: PreviewProvider {
    static let manager = CoreDataManager.instance
    static var previews: some View {
        EditTrainingView()
            .environmentObject(MainViewModel())
    }
}
