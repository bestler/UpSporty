//
//  Goals.swift
//  Test 25
//
//  Created by 4Func on 19/10/22.
//

import SwiftUI

struct GoalCardView: View {
    
    let screenWidth  = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var goalCardInstance: GoalCard
    
    var body: some View {
        HStack(spacing: 0){
            Image(systemName: goalCardInstance.sportIcon)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 64, height: 40, alignment: .leading)
                .foregroundColor(goalCardInstance.sportColor)
            VStack(alignment: .leading, spacing: 10){
                Text(goalCardInstance.sportName)
                    .font(.system(size: 28))
                    .foregroundColor(Color("blackText"))
                    .fontWeight(.bold)
                    .padding(.leading, 3)
                HStack{
                    Image(systemName: goalCardInstance.targetIcon)
                        .font(.system(size: 28))
                        .fontWeight(.bold)
                        .foregroundColor(Color("grayText"))
                    Text("\(goalCardInstance.target) \(goalCardInstance.targetMeasure)")
                        .font(.system(size: 23))
                }
                HStack{
                    Image(systemName: goalCardInstance.clockIcon)
                        .font(.system(size: 28))
                        .fontWeight(.bold)
                        .foregroundColor(Color("grayText"))
                    Text("\(goalCardInstance.targetTime) \(goalCardInstance.targetTimeMeaseure)")
                        .font(.system(size: 23))
                }
            }
            .padding(.leading, 20)
            Spacer()
            Image(systemName: goalCardInstance.chevronIcon)
                .font(.system(size: 24))
                .fontWeight(.bold)
                .foregroundColor(Color("grayText"))
        }
    }
}

struct Goals: View {
    
    @State var goalCardAtAll = [
        GoalCard(
            sportIcon: "figure.run",
            sportColor: .green,
            sportName: "Running",
            targetIcon: "flag",
            target: 2000,
            targetMeasure: "mt",
            clockIcon: "stopwatch",
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
            target: 130,
            targetMeasure: "pt",
            clockIcon: "stopwatch",
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
    
    @State private var showingSheet = false

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
