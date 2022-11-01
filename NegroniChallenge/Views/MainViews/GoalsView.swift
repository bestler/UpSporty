//
//  GoalsView.swift
//  Test 25
//
//  Created by 4Func on 19/10/22.
//

import SwiftUI

struct GoalsView: View {
    @EnvironmentObject var vm: MainViewModel
    
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
                    if(vm.allGoals.isEmpty){
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
                            List {
                                ForEach(vm.allGoals) { goal in
                                    Section{
                                        ZStack{
                                            GoalCardView(goal: goal)
                                            NavigationLink( destination: DetailView(detail: goal)){
                                                EmptyView()
                                            }.opacity(0)
                                        }
                                    }
                                }
                                .onConfirmedDelete(
                                    title: { index in
                                        if let sportName = SportModel.getSport(for: vm.allGoals[index.first!].sportID)?.sportName.rawValue {
                                            return "Delete the \(sportName) card?"
                                        }
                                       return ""
                                    },
                                    message: "This cannot be undone.",
                                    action: { index in
                                        vm.deleteGoal(goal: vm.allGoals[index.first!])
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
                            NewGoalView(showingSheet: self.$showingSheet)
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
        GoalsView()
            .environmentObject(MainViewModel())
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
