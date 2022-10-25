//
//  Goals.swift
//  Test 25
//
//  Created by 4Func on 19/10/22.
//

import SwiftUI

struct Goals: View {
    @EnvironmentObject var vm: MainViewModel
    @State var goalCardAtAll = [
        GoalCard(
            sportIcon: "figure.run",
            sportColor: .green,
            sportName: "Running",
            targetIcon: "flag",
            clockIcon: "stopwatch", target: 2000,
            targetMeasure: "mt",
            targetTime: Int(2.00),
            targetTimeMeaseure: "mins",
            isCompleted: false,
            yearCompletion: 0,
            progress: 71
        ),
        
        GoalCard(
            sportIcon: "figure.archery",
            sportColor: .yellow,
            sportName: "Archery",
            targetIcon: "flag",
            clockIcon: "stopwatch", target: 130,
            targetMeasure: "pt",
            targetTime: Int(0),
            targetTimeMeaseure: "--",
            isCompleted: false,
            yearCompletion: 0,
            progress: 46
        )
    ]
    
    let screenWidth  = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    @GestureState var isDragging = false
    
    @State private var showingAlert = false
    @State private var deleteIndexSet: IndexSet?
    
    @State var showingSheet = false

    var body: some View {
        ZStack{
            Color("mainBackground")
                .ignoresSafeArea()
            NavigationStack{
                ZStack{
                    Color("mainBackground")
                        .ignoresSafeArea()
                    if(goalCardAtAll.isEmpty){
                        VStack{
                            Image(systemName: "plus.circle")
                                .font(.system(size: 140))
                                .foregroundColor(Color.gray)
                                .padding(.bottom, 20)
                            Text("Add a new goal")
                                .font(.system(size: 30))
                                .foregroundColor(Color.gray)
                        }
                    } else {
                        VStack{
                            List(0 ..< 1) { goalCard in
                                ForEach(goalCardAtAll) { goalCard in
                                    Section{
                                        ZStack{
                                            GoalCardView(goalCardInstance: goalCard)
                                            NavigationLink( destination: DetailView( detail: goalCard)){
                                                EmptyView()
                                            }.opacity(0)
                                        }
                                    }
                                }
                                
                                .onConfirmedDelete(
                                    title: {indexSet in
                                        "Delete the \(goalCardAtAll[indexSet.first!].sportName) card?"
                                    },
                                    message: "This cannot be undone.",
                                    action: { indexSet in
                                        goalCardAtAll.remove(atOffsets: indexSet)
                                    }
                                )
                                
                                .listRowSeparator(.hidden)
                            }
                            .onAppear(perform: {
                                UITableView.appearance().contentInset.bottom = 40
                            })
                            .scrollContentBackground(.hidden)
                            
                            .listStyle(InsetGroupedListStyle())
                        }
                    }
                }
                .navigationTitle("Goals")
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button{
                            showingSheet.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                        .sheet(isPresented: $showingSheet) {
                            NewGoal(showingSheet: self.$showingSheet)
                                .environmentObject(vm)
                        }
                    }
                }
            }
        }
    }
}

struct Goals_Previews: PreviewProvider {
    static var previews: some View {
        Goals()
    }
}

extension DynamicViewContent {
    func onConfirmedDelete(title: @escaping (IndexSet) -> String, message: String? = nil, action: @escaping (IndexSet) -> Void) -> some View {
        DeleteConfirmation(source: self, title: title, message: message, action: action)
    }
}

struct DeleteConfirmation<Source>: View where Source: DynamicViewContent {
    let source: Source
    let title: (IndexSet) -> String
    let message: String?
    let action: (IndexSet) -> Void
    @State var indexSet: IndexSet = []
    @State var isPresented: Bool = false
    
    var body: some View {
        source
            .onDelete { indexSet in
                self.indexSet = indexSet
                isPresented = true
            }
            .alert(isPresented: $isPresented) {
                Alert(
                    title: Text(title(indexSet)),
                    message: message == nil ? nil : Text(message!),
                    primaryButton: .cancel(),
                    secondaryButton: .destructive(
                        Text("Delete"),
                        action: {
                            withAnimation {
                                action(indexSet)
                            }
                        }
                    )
                )
            }
    }
}
