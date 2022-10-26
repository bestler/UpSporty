//
//  FinalGoal.swift
//  NegroniChallenge
//
//  Created by Matteo Fontana on 25/10/22.
//

import SwiftUI

struct FinalGoal: View {
    @EnvironmentObject var vm: MainViewModel
    let screenWidth  = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    @State private var date = Date()
    
    @ObservedObject var input = NumbersOnly()
    
    var body: some View {
        NavigationStack{
            
            ZStack{
                Color("mainBackground")
                    .ignoresSafeArea()
                VStack {
                    Text("Final Goal")
                        .foregroundColor(Color("blackText"))
                        .font(.system(size: 26))
                        .padding(.top, 15)
                        .bold()
                    Text("Select the metrics of your new goal")
                        .foregroundColor(Color("blackText"))
                        .padding(.top, 1)
                        .font(.system(size: 18))
                        .padding(.bottom, 35)
                    VStack(alignment: .leading){
                        Text("Set your final goal date")
                            .foregroundColor(Color("grayText"))
                            .font(.system(size: 14))
                            .bold()
                        HStack {
                            Image(systemName: "calendar")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                            DatePicker(
                                    "Start Date",
                                    selection: $vm.dueDate,
                                    displayedComponents: [.date]
                            )
                        }
                        .padding(20)
                        .background(Color("cardColor"))
                        .cornerRadius(20)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 25)
                    VStack(alignment: .leading){
                        Text("Set your final goal metrics to reach")
                            .foregroundColor(Color("grayText"))
                            .font(.system(size: 14))
                            .bold()
                        VStack{
                            HStack {
                                Image(systemName: "figure.stand.line.dotted.figure.stand")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                Text("Distance")
                                    .foregroundColor(Color("grayText"))
                                    .font(.system(size: 20))
                                Spacer()
                                TextField("Mt", text: $vm.target)
                                    .keyboardType(.decimalPad)
                                
                                    .disableAutocorrection(true)
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(Color("blackText"))
                                    .font(.system(size: 20))
                            }
                            .padding(.bottom, 20)
                            HStack {
                                Image(systemName: "timer")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                Text("Time")
                                    .foregroundColor(Color("grayText"))
                                    .font(.system(size: 20))
                                Spacer()
                                Text("Picker here")
                                    .foregroundColor(Color("blackText"))
                                    .font(.system(size: 20))
                            }
                            
                        }
                        .padding(20)
                        .background(Color("cardColor"))
                        .cornerRadius(20)
                    }
                    .padding(.horizontal, 20)
                    Spacer()
                }
                
            }
            
        }
    }
}

struct FinalGoal_Previews: PreviewProvider {
    static var previews: some View {
        FinalGoal()
            .environmentObject(MainViewModel())
    }
}

class NumbersOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter { $0.isNumber }
            
            if value != filtered {
                value = filtered
            }
        }
    }
}
