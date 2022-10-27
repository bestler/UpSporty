//
//  DetailTrainingView.swift
//  NegroniChallenge
//
//  Created by Simon Bestler on 27.10.22.
//

import SwiftUI

struct DetailTrainingView: View {
    
    @State private var distance : String = "";
    @State private var repetitionCount : Int = 1;
    
    var body: some View {
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
                            Stepper("Repetitons: \(repetitionCount) x", onIncrement: {
                                repetitionCount += 1
                            }, onDecrement: {
                                if repetitionCount > 1{
                                    repetitionCount -= 1
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
                                TextField("Mt", text: $distance)
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
        
        }
    }


struct DetailTrainingView_Previews: PreviewProvider {
    static var previews: some View {
        DetailTrainingView()
    }
}
