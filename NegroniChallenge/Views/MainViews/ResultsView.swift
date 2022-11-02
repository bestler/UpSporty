//
//  ResultsView.swift
//  Test 25
//
//  Created by 4Func on 19/10/22.
//

import SwiftUI

/*
 LazyVGrid(columns: numberColumns, spacing: 20) {
 ForEach(Array(vm.results.keys), id: \.self) { year in
 Text(year)
 ForEach(vm.results[year]!, id: \.self) { goal in
 Text(SportModel.getSport(for: goal.sportID)?.sportName.rawValue ?? "")
 }
 }
 */

struct ResultsView: View {
    @EnvironmentObject var vm: MainViewModel
    let screenWidth  = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    private var data: [Int] = Array(1...20)
    
    private let numberColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let numberOfColumns: Int = 3
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                Color("mainBackground")
                    .ignoresSafeArea()
                ScrollView {
                    ForEach(Array(vm.results.keys), id: \.self) { year in
                        HStack{
                            Text(year)
                                .foregroundColor(.secondary)
                                .font(.headline)
                            Spacer()
                        }
                        .padding(.horizontal)
                        LazyVGrid(columns: numberColumns, spacing: 10) {
                        ForEach(vm.results[year]!, id: \.self) { goal in
                                ResultsCardView(goal: goal)
                                .frame(width: 150, height: 150)
                            }
                        }
                        .padding(.top, -20)
                    }
                }
            }
            .navigationTitle("Results")
            .onAppear {
                vm.getGoalResults()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        //This should filter
                    }) {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .font(.system(size: 18))
                    }
                }
            }
        }
        
    }
}

struct Results_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
            .environmentObject(MainViewModel())
    }
}
