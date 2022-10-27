//
//  DetailView.swift
//  Test 25
//
//  Created by Matteo Fontana on 20/10/22.
//

import SwiftUI

struct DetailView: View {
    
    let detail: GoalEntity
    
    let screenWidth  = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
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
                    
                    ForEach(0..<4) { item in
                        NavigationLink {
                            TrainingResultView()
                        } label: {
                            TrainingRowView()
                                .padding(.leading, nil) //spostare il valore
                                .padding(.trailing)
                        }
                        .buttonStyle(.plain)
                    }
                    
                    
                    
                    
                    
                }
                
            }
        }
        
        .navigationBarTitle(Text("Sport title"), displayMode: .inline) //\(detail.sportName)
        .navigationBarItems(trailing:
                Button(action: {
            
        }) {
            Text("Edit").bold()
        }
        )
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(detail: GoalEntity())
        }
        
    }
}
