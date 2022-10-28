//
//  DetailView.swift
//  Test 25
//
//  Created by Matteo Fontana on 20/10/22.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var vm: MainViewModel
    @State private var showTrainingSheetView: Bool = false
    
    let goal: GoalEntity
    var sport: SportModel? = nil
    
    let screenWidth  = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    init(detail: GoalEntity) {
        self.goal = detail
        if let sport = SportModel.getSport(for: goal.sportID) {
            self.sport = sport
        }
    }
    
    var body: some View {
        
        ZStack {
            Color("mainBackground")
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 20) {
                    TabView {
                        //  CircularGraph(progress: detail.progress, colored: detail.sportColor)
                        Text("Second")
                        Text("Third")
                        Text("Fourth")
                    }
                    .frame(width: screenWidth, height: screenWidth)
                    .tabViewStyle(.page)
                    .onAppear {
                        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color("blackText"))
                        UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color("blackText")).withAlphaComponent(0.2)
                    }
                    
                    ForEach(vm.currentTrainingSheet) { training in
                        NavigationLink {
                            TrainingResultView(training: training)
                                .environmentObject(vm)
                        } label: {
                            TrainingRowView(trainingStep: training)
                                .padding(.leading, training.isExcercise ? 60 : nil)
                                .padding(.trailing)
                        }
                        .buttonStyle(.plain)
                    }
                    
                    
                    
                    
                    
                }
                
            }
        }
        .navigationBarTitle(Text(sport?.sportName.rawValue ?? "Sport"), displayMode: .inline)
        .navigationBarItems(trailing:
                                Button("Edit", action: {
            showTrainingSheetView.toggle()
        })
        )
        .fullScreenCover(isPresented: $showTrainingSheetView) {
            TrainingSheetView(goal: goal)
        }
        .onAppear {
            vm.getTrainingSheet(for: goal)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static let manager = CoreDataManager.instance
    static var previews: some View {
        NavigationStack {
            DetailView(detail: GoalEntity(context: manager.context))
                .environmentObject(MainViewModel())
        }
        
    }
}
