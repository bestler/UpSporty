//
//  TodayView.swift
//  Test 25
//
//  Created by 4Func on 19/10/22.
//

import SwiftUI

struct TodayView: View {
    @EnvironmentObject var vm: MainViewModel
    @State private var showingSheet = false
    @State private var midY: CGFloat = 0.0
    @State var showHalfSheet: Bool = false
    
    let screenWidth  = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
   
    
    
    var body: some View {
        NavigationStack{
            VStack {
                if(vm.todayGoals.isEmpty) {
                    ZStack {
                        Color("mainBackground")
                            .ignoresSafeArea()
                        VStack{
                            Image(systemName: "figure.walk")
                                .font(.system(size: 140))
                                .foregroundColor(Color.gray)
                                .padding(.bottom, 20)
                            Text("No activties for Today")
                                .font(.system(size: 30))
                                .foregroundColor(Color.gray)
                        }
                    }
                } else {
                    ZStack {
                        Color("mainBackground")
                            .ignoresSafeArea()
                        VStack{
                            if vm.todayGoals.count > 1 {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                    ForEach(vm.todayGoals) { goal in
                                            Button {
                                                vm.selectedToday = goal
                                            } label: {
                                                Text(SportModel.getSport(for: goal.sportID)?.sportName.rawValue ?? "")
                                                    .foregroundColor(.white)
                                                    .padding()
                                                    .background(vm.selectedToday == goal ? .blue : .blue.opacity(0.5))
                                                    .cornerRadius(10)
                                            }
                                        }
                                    }
                                }
                                .padding()
                            }
                            List {
                                    Section {
                                        if let goal = vm.goalToShow {
                                            Text(SportModel.getSport(for: goal.sportID)?.sportName.rawValue ?? "")
                                        }
                                        
                                            //                                            GoalCardTodayView()
                                            //                                                .environmentObject(vm)
                                        
                                    }
                                    Section{
                                        ForEach(vm.todayTrainingSheet) { training in
                                            Button {
                                                vm.selectedTraining = training
                                                showHalfSheet.toggle()
                                            } label: {
                                                HStack{
                                                    Image(systemName: "plus.circle")
                                                        .foregroundColor(Color("blackText"))
                                                        .font(.system(size: 40))
                                                    VStack(alignment: .leading){
                                                        Text(training.isExcercise ? TrainingType.exercise.rawValue : TrainingType.assestment.rawValue)
                                                            .foregroundColor(Color("blackText"))
                                                            .font(.system(size: 20))
                                                            .bold()
                                                        Text("Repeat")
                                                            .foregroundColor(Color("grayText"))
                                                            .font(.system(size: 16))
                                                        Text("\(training.repeatCountActual)/\(training.repeatCountTotal)")
                                                            .foregroundColor(Color("grayText"))
                                                            .font(.system(size: 16))
                                                    }
                                                    
                                                }
                                            }
                                        }
                                        
                                    }
                                   
                                .listRowSeparator(.hidden)
                            }
                            .scrollContentBackground(.hidden)
                            .listStyle(InsetGroupedListStyle())
                        }
                        
                    }
                    
                    
                }
                
            }
            .navigationTitle("Today")
            .onAppear(perform: {
                UITableView.appearance().contentInset.bottom = 40
                vm.getTodayGoals()
            })
            .sheet(isPresented: $showHalfSheet) {
                if let selectedTraining = vm.selectedTraining {
                    ResultInputTodayView(presentationDetents: $vm.todayResultFilter, training: selectedTraining)
                        .presentationDetents(([.large, .medium]), selection: $vm.todayResultFilter)
                } else {
                    Text("nil")
                }
            }
            
        }
        
    }
    
}

struct Today_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
            .environmentObject(MainViewModel())
    }
}


