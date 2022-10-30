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
    

    
    var body: some View {
        NavigationStack {
            ZStack{
                Color("mainBackground")
                    .ignoresSafeArea()
                    .navigationTitle("Exercise")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar{
                        ToolbarItem(placement: .confirmationAction){
                            Button("Save"){
                                print(target)
                                vm.trainingRepCount = repCount
                                vm.trainingTarget = target
                                vm.updateTrainingFromSheet()
                                vm.saveNewTrainingStep()
                            //TODO: CHECK IF SOMETHING IS NOT GOOD
                                dismiss()
                                dismiss()
                            }
                        }
                    }

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
                    VStack(alignment: .leading){
                        Text("Set the repetitons")
                            .foregroundColor(Color("grayText"))
                            .font(.system(size: 14))
                            .bold()
                        VStack{
                            HStack {
                                Image(systemName: "repeat")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                Stepper("Repetitons: \(repCount) x", onIncrement: {
                                    repCount += 1
                                }, onDecrement: {
                                    if repCount > 1{
                                        repCount -= 1
                                    }

                                })
                            }
                            
                        }
                        .padding(20)
                        .background(Color("cardColor"))
                        .cornerRadius(20)
                        .padding(.bottom, 20)

                        VStack(alignment: .leading) {
                            Text("Set the distance")
                                .foregroundColor(Color("grayText"))
                                .font(.system(size: 14))
                                .bold()
                            VStack(){
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
                        
                            }
                            .padding(20)
                            .background(Color("cardColor"))
                        .cornerRadius(20)
                        }
                        
        
                        Spacer()
                    }.padding(.horizontal, 20)
                        
                    }
                    
            }
        }.onAppear(){
            repCount = vm.trainingRepCount
            target = vm.trainingTarget
            
        }
        
    }
    }


struct DetailTrainingView_Previews: PreviewProvider {
    static var previews: some View {
        DetailTrainingView()
            .environmentObject(MainViewModel())
    }
}
