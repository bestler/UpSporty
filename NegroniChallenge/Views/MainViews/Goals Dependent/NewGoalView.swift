//
//  NewGoalView.swift
//  Test 25
//
//  Created by Matteo Fontana on 21/10/22.
//

import SwiftUI

struct NewGoalView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var vm: MainViewModel
    @Binding var showingSheet: Bool
    let screenWidth  = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    @State private var selectedTab = Tab.First
    
    private enum Tab {
        case First, Second
    }
    
    @State var isSearching = false
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                Color("mainBackground")
                    .ignoresSafeArea()
                TabView(selection: $selectedTab){
                    ActivitySelectionView()
                        .tag(Tab.First)
                        .gesture(DragGesture())
                    FinalGoalView()
                        .tag(Tab.Second)
                        .gesture(DragGesture())
                }
                .tabViewStyle(PageTabViewStyle())
                .onAppear {
                    UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color("blackText"))
                    UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color("blackText")).withAlphaComponent(0.2)
                }
            }
            .navigationBarTitle(Text("New Goal"), displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                if self.selectedTab == Tab.First {
                    if vm.checkSportSelection() {
                        self.selectedTab = Tab.Second
                    }
                } else if self.selectedTab == Tab.Second{
                    vm.saveNewGoal()
                    dismiss()
                }
            }) {
                if self.selectedTab == Tab.Second {
                    Text("Done").bold()
                } else {
                    Text("Next").bold()
                }
            }
            )
            .navigationBarItems(leading:
                                    Button(action: {
                if self.selectedTab == Tab.First {
                    dismiss()
                } else if self.selectedTab == Tab.Second{
                    self.selectedTab = Tab.First
                }
            }) {
                if self.selectedTab == Tab.First {
                    Text("Cancel")
                } else {
                    Text("Back")
                }
            }
            )
        }
    }
}

struct NewGoal_Previews: PreviewProvider {
    static var previews: some View {
        NewGoalView(showingSheet: GoalsView().$showingSheet)
            .environmentObject(MainViewModel())
    }
}
