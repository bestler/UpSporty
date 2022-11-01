//
//  CreateTrainingView.swift
//  NegroniChallenge
//
//  Created by Simon Bestler on 26.10.22.
//

import SwiftUI

struct EditTrainingSheetView: View {
    @EnvironmentObject var vm: MainViewModel
    
    
    @State private var isModalShown = false
    @State private var selectedTrainingInSheet: TrainingEntity? = nil

    var body: some View {
        ZStack {
            Color("mainBackground")
                .ignoresSafeArea()
            VStack {
                Text("Manage your trainings")
                    .foregroundColor(Color("blackText"))
                    .font(.title)
                    .padding(.top, 15)
                    .bold()
                Text("Plan your training to reach your goal 📈!")
                    .foregroundColor(Color("blackText"))
                    .padding(.top, 1)
                    .font(.subheadline)
                    .padding(.bottom, 20)
                
                    Button {
                        isModalShown.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Create new training")
                            Spacer()
                        }
                        .padding(15)
                        .background(Color("cardColor"))
                        .cornerRadius(10)
                    }
                    .sheet(isPresented: $isModalShown){
                        EditTrainingView()
                            .environmentObject(vm)
                    }
                    .padding(20)
                
                List{
                    Section(vm.currentTrainingSheet.isEmpty ? "" : "Already Scheduled Trainings") {
                        ForEach(vm.currentTrainingSheet) { training in
                            
                            Button {
                                vm.selectedTrainingInSheet = training
                                vm.trainingType = training.isExcercise ? .exercise : .assestment
                                vm.trainingDueDate = training.dueDate ?? Date()
                                vm.trainingRepCount = Int(training.repeatCountTotal)
                                vm.trainingTarget = String(training.target)
                                print("Target " + String(vm.trainingTarget))
                                isModalShown.toggle()
                            } label: {
                                VStack(alignment: .leading, spacing: 3) {
                                    HStack {
                                        if(training.isExcercise){
                                            Image(systemName: "note.text")
                                            Text("Exercise \(training.repeatCountTotal) x \(training.target) m")
                                                .font(.headline)
                                            
                                        }else {
                                            Image(systemName: "flag")
                                            Text("Assesment")
                                                .font(.headline)
                                                .bold()
                                        }
                                        Spacer()
                                    }
                                    Text(dateFormatted(training.dueDate ?? Date()))
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .buttonStyle(.plain)
                        }
                        .onDelete(perform: vm.deleteTrainingFromSheet)
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(.insetGrouped)
                Spacer()
            }
        }
        
    }
    func removeRows(at offsets: IndexSet) {
        print("Deleted")
    }
}

struct EditTrainingSheetView_Previews: PreviewProvider {
    static var previews: some View {
        EditTrainingSheetView()
            .environmentObject(MainViewModel())
    }
}
