//
//  DetailTrainingView.swift
//  NegroniChallenge
//
//  Created by Simon Bestler on 27.10.22.
//

import SwiftUI

struct DetailTrainingView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var vm: MainViewModel
    
    @State private var repCount : Int = 0;
    @State private var target : String = "";
    @State private var showAlert  = false;
    

    
    var body: some View {
        NavigationStack {
            ZStack{
                Color("mainBackground")
                    .ignoresSafeArea()
                    

                VStack{
                    Text("Customize your training")
                        .foregroundColor(Color("blackText"))
                        .font(.system(size: 26))
                        .padding(.top, 15)
                        .bold()
                    Text("Set the repetitons and the distance")
                        .foregroundColor(Color("blackText"))
                        .padding(.top, 1)
                        .font(.system(size: 18))
                        .padding(.bottom, 20)
                        .multilineTextAlignment(.center)
                    List {
                        Section("Set the repetitons") {
                            HStack {
                                Image(systemName: "repeat")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                Stepper("Repetitons: \(repCount) x", onIncrement: {
                                    repCount += 1
                                }, onDecrement: {
                                    if repCount > 1 {
                                        repCount -= 1
                                    }
                                })
                            }
                            .padding([.top, .bottom], 3)
                        }
                        
                        Section("Set the distance") {
                            HStack {
                                Image(systemName: "figure.stand.line.dotted.figure.stand")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                Text("Distance")
                                    .foregroundColor(Color("grayText"))
                                    .font(.system(size: 20))
                                Spacer()
                                TextField("Mt", text: $target)
                                    .keyboardType(.decimalPad)
                                    .disableAutocorrection(true)
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(Color("blackText"))
                                    .font(.system(size: 20))
                            }
                            .padding([.top, .bottom], 6)
                        }
                    }
                    .scrollDisabled(true)
                    .scrollContentBackground(.hidden)
                }
                    
            }
            .navigationTitle("Exercise")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .confirmationAction){
                    Button("Save"){
                        print(target)
                        if(Int(target) ?? 0 <= 0){
                            showAlert.toggle()
                            
                        } else {
                            vm.trainingRepCount = repCount
                            vm.trainingTarget = target
                            vm.updateTrainingFromSheet()
                            vm.saveNewTrainingStep()
                            dismiss()
                            dismiss()
                        }

                    }
                }
            }
        }
        .onAppear(){
            repCount = vm.trainingRepCount
            target = vm.trainingTarget
            
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Invalid input"),
                          message: Text("Distance should be greater the Zero"),
                          dismissButton: .default(Text("Dismiss")))
                }
        
    }
    }


struct DetailTrainingView_Previews: PreviewProvider {
    static var previews: some View {
        DetailTrainingView()
            .environmentObject(MainViewModel())
    }
}

