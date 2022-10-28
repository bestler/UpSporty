//
//  TodayView.swift
//  Test 25
//
//  Created by 4Func on 19/10/22.
//

import SwiftUI

struct TodayView: View {
    @EnvironmentObject var vm: MainViewModel
    
    let screenWidth  = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    @State private var showingSheet = false
    
    @State private var midY: CGFloat = 0.0
    
    @State var showHalfSheet: Bool = false
    
    var body: some View {
        ZStack{
            Color("mainBackground")
                .ignoresSafeArea()
            NavigationStack{
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
                    .navigationTitle("Today")
                    .toolbar{
                        ToolbarItem(placement: .navigationBarTrailing){
                            Button{
                                self.showingSheet.toggle()
                            } label: {
                                Image(systemName: "person.crop.circle")
                            }
                            .sheet(isPresented: $showingSheet) {
                                //Preferences(showingSheet: self.$showingSheet)
                            }
                        }
                    }
                    .ignoresSafeArea()
                } else {
                    ZStack {
                        Color("mainBackground")
                            .ignoresSafeArea()
                        VStack{
                            List(0 ..< 1) { goalCard in
                                ForEach(vm.todayGoals) { goalCard in
                                    Section{
                                        ZStack{
//                                            GoalCardTodayView()
//                                                .environmentObject(vm)
                                        }
                                    }
                                    Section{
                                        ZStack{
                                            HStack{
                                                Image(systemName: "plus.circle")
                                                    .foregroundColor(Color("blackText"))
                                                    .font(.system(size: 40))
                                                    .onTapGesture {
                                                        showHalfSheet.toggle()
                                                    }
                                                    .sheet(isPresented: $showHalfSheet, content: {
                                                        ResultInputTodayView(showHalfSheet: self.$showHalfSheet)
                                                            .presentationDetents([.large, .medium, .fraction(0.55)])
                                                    })
                                                VStack(alignment: .leading){
                                                    Text("Excercise 5x200mt")
                                                        .foregroundColor(Color("blackText"))
                                                        .font(.system(size: 20))
                                                        .bold()
                                                    Text(/*"Repeat"*/ vm.test)
                                                        .foregroundColor(Color("grayText"))
                                                        .font(.system(size: 16))
                                                    Text("2/5")
                                                        .foregroundColor(Color("grayText"))
                                                        .font(.system(size: 16))
                                                }
                                            }
                                        }
                                    }
                                }
                                .listRowSeparator(.hidden)
                            }
                            .onAppear(perform: {
                                UITableView.appearance().contentInset.bottom = 40
                            })
                            .scrollContentBackground(.hidden)
                            .listStyle(InsetGroupedListStyle())
                        }
                        
                    }
                    .navigationTitle("Today")
                    .toolbar{
                        ToolbarItem(placement: .navigationBarTrailing){
                            Button{
                                showingSheet.toggle()
                            } label: {
                                Image(systemName: "person.crop.circle")
                            }
                            .sheet(isPresented: $showingSheet) {
                                //Preferences(showingSheet: self.$showingSheet)
                            }
                        }
                    }
                    
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
