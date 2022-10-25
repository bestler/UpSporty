//
//  Today.swift
//  Test 25
//
//  Created by 4Func on 19/10/22.
//
struct GoalCardViewToday: View {
    
    let screenWidth  = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var goalCardInstance: GoalCard
    
    @State var progressZero: CGFloat = -10
    @State private var numberGraph: Double = 0
    
    var body: some View {
        VStack{
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
            }
            VStack(alignment: .leading) {
                LinearGraph(progress: goalCardInstance.progress, colored: goalCardInstance.sportColor)
                .onAppear() {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.9, blendDuration:100)) {
                        progressZero = goalCardInstance.progress
                        numberGraph = goalCardInstance.progress + 0
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
}


import SwiftUI

struct Today: View {
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
        )
    ]
    
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
                if(goalCardAtAll.isEmpty) {
                    
                    
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
                                Preferences(showingSheet: self.$showingSheet)
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
                                ForEach(goalCardAtAll) { goalCard in
                                    Section{
                                        ZStack{
                                            GoalCardViewToday(goalCardInstance: goalCard)
                                            /*NavigationLink( destination: DetailView( detail: goalCard)){
                                                EmptyView()
                                            }.opacity(0)*/
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
                                                        HalfModalTodayView(showHalfSheet: self.$showHalfSheet)
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
                                Preferences(showingSheet: self.$showingSheet)
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
        Today()
            .environmentObject(MainViewModel())
    }
}
