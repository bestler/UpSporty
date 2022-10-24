//
//  NewGoal.swift
//  Test 25
//
//  Created by Matteo Fontana on 21/10/22.
//

import SwiftUI

struct NewGoal: View {
    
    @State private var sportIndex = 0
    
    @Binding var showingSheet: Bool
    
    @State var sportSelectionArray = [
        Sport(
            sportIcon: "figure.run",
            sportName: "Running",
            sportColor: .green,
            isSelected: false
        ),
        Sport(
            sportIcon: "figure.archery",
            sportName: "Archery",
            sportColor: .yellow,
            isSelected: false
        ),
        Sport(
            sportIcon: "figure.track.and.field",
            sportName: "Obstacle Course",
            sportColor: .blue,
            isSelected: false
        ),
        Sport(
            sportIcon: "figure.mind.and.body",
            sportName: "Meditation",
            sportColor: .red,
            isSelected: false
        ),
    ]
    
    let screenWidth  = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    @State private var selectedTab = Tab.First
    
    private enum Tab {
        case First, Second, Third, Fourth
    }

    var body: some View {
        
        NavigationStack{
            ZStack{
                Color("mainBackground")
                    .ignoresSafeArea()
                /*VStack{
                    Section{
                        Picker(selection: $sportIndex, label:
                            Text("Sport")
                        ){
                            Text("item one")
                            Text("item one")
                            Text("item one")
                        }
                    }
                }*/
                TabView(selection: $selectedTab){
                    ActivitySelection()
                        .tag(Tab.First)
                    Text("Second")
                        .tag(Tab.Second)
                    Text("Third")
                        .tag(Tab.Third)
                    Text("Fourth")
                        .tag(Tab.Fourth)
                }
                //.frame(width: screenWidth, height: screenWidth)
                .tabViewStyle(.page)
                .onAppear {
                    UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color("blackText"))
                    UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color("blackText")).withAlphaComponent(0.2)
                }
            }
            .navigationBarTitle(Text("New Goal"), displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    if self.selectedTab == Tab.First {
                        self.selectedTab = Tab.Second
                    } else if self.selectedTab == Tab.Second{
                        self.selectedTab = Tab.Third
                    } else if self.selectedTab == Tab.Third{
                        self.selectedTab = Tab.Fourth
                    } else if self.selectedTab == Tab.Fourth{
                        //Add element to Array and...
                        self.showingSheet.toggle()
                    }
                }) {
                    if self.selectedTab == Tab.Fourth {
                        Text("Done").bold()
                    } else {
                        Text("Next").bold()
                    }
                }
            )
            .navigationBarItems(leading:
                Button(action: {
                    if self.selectedTab == Tab.First {
                        self.showingSheet.toggle()
                    } else if self.selectedTab == Tab.Second{
                        self.selectedTab = Tab.First
                    } else if self.selectedTab == Tab.Third{
                        self.selectedTab = Tab.Second
                    } else if self.selectedTab == Tab.Fourth{
                        self.selectedTab = Tab.Third
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

/*struct NewGoal_Previews: PreviewProvider {
    static var previews: some View {
    NewGoal(showingSheet: self.$showingSheet)
    }
}*/
