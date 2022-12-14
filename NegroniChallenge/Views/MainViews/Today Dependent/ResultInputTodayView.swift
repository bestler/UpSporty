//
//  ResultInputTodayView.swift
//  NegroniChallenge
//
//  Created by Matteo Fontana on 24/10/22.
//

import SwiftUI

struct ResultInputTodayView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: MainViewModel
    @Binding var presentationDetents: PresentationDetent
    let goal: GoalEntity
    let training: TrainingEntity
    
    @State var selectedStrenght: Int = 0
    
    let screenWidth  = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    @State private var hoursSelection = 0
    @State private var minutesSelection = 0
    @State private var secondsSelection = 0
    @State private var millisecondsSelection = 0
    @State private var selectedResult: TrainingResultEntity? = nil
    
    private let hours = [Int](0..<24)
    private let minutes = [Int](0..<60)
    private let seconds = [Int](0..<60)
    private let milliseconds = [Int](0..<100)
    
    var body: some View {
        NavigationStack{
            ZStack(alignment: .top) {
                Color("mainBackground")
                    .ignoresSafeArea()
                
                
                    VStack {
                        if presentationDetents == .medium {
                        if !vm.selectedResultsToday.isEmpty {
                            HStack {
                                Image(systemName: "repeat")
                                Text("Repeat number: \(vm.selectedResultsToday[0].number)/\(training.repeatCountTotal)")
                                Spacer()
                            }
                            .padding(15)
                            .background(Color("cardColor"))
                            .cornerRadius(10)
                            .padding(.horizontal)
                            VStack {
                                Grid {
                                    GridRow {
                                        Text("h")
                                        Text("m")
                                        Text("s")
                                        Text("ms")
                                    }
                                    .padding(.top)
                                    
                                    GridRow {
                                        Picker("", selection: $hoursSelection) {
                                            ForEach(hours, id: \.self) { hour in
                                                Text("\(hour)")
                                            }
                                        }
                                        .pickerStyle(.wheel)
                                        
                                        Picker("", selection: $minutesSelection) {
                                            ForEach(minutes, id: \.self) { minute in
                                                Text("\(minute)")
                                            }
                                        }
                                        .pickerStyle(.wheel)
                                        
                                        Picker("", selection: $secondsSelection) {
                                            ForEach(seconds, id: \.self) { second in
                                                Text("\(second)")
                                            }
                                        }
                                        .pickerStyle(.wheel)
                                        
                                        Picker("", selection: $millisecondsSelection) {
                                            ForEach(milliseconds, id: \.self) { millisecond in
                                                Text("\(millisecond)")
                                            }
                                        }
                                        .pickerStyle(.wheel)
                                    }
                                }
                            }
                            .background(Color("cardColor"))
                            .cornerRadius(10)
                            .padding()
                        } 
                    }
                        else {
                            List {
                                ForEach(vm.selectedResultsToday) { result in
                                    ResultsEditRowView(result: result)
                                        .onTapGesture {
                                            let temp = result
                                            if temp == vm.selectedResultsToday.first {
                                                selectedResult = result
                                            } else if let selectedResult, vm.calculateMilliseconds(hour: hoursSelection, minute: minutesSelection, second: secondsSelection, millisecond: millisecondsSelection) != 0 && selectedResult.number == (temp.number - 1) {
                                                self.selectedResult = result
                                            }
                                            
                                        }
                                    if selectedResult == result {
                                        VStack {
                                            Grid {
                                                GridRow {
                                                    Text("h")
                                                    Text("m")
                                                    Text("s")
                                                    Text("ms")
                                                }
                                                
                                                GridRow {
                                                    Picker("", selection: $hoursSelection) {
                                                        ForEach(hours, id: \.self) { hour in
                                                            Text("\(hour)")
                                                        }
                                                    }
                                                    .pickerStyle(.wheel)
                                                    
                                                    Picker("", selection: $minutesSelection) {
                                                        ForEach(minutes, id: \.self) { minute in
                                                            Text("\(minute)")
                                                        }
                                                    }
                                                    .pickerStyle(.wheel)
                                                    
                                                    Picker("", selection: $secondsSelection) {
                                                        ForEach(seconds, id: \.self) { second in
                                                            Text("\(second)")
                                                        }
                                                    }
                                                    .pickerStyle(.wheel)
                                                    
                                                    Picker("", selection: $millisecondsSelection) {
                                                        ForEach(milliseconds, id: \.self) { millisecond in
                                                            Text("\(millisecond)")
                                                        }
                                                    }
                                                    .pickerStyle(.wheel)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            .scrollContentBackground(.hidden)
                        }

                }
            }
            .navigationTitle("Insert time")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        vm.resetContext()
                        vm.todayResultFilter = .medium
                        dismiss()
                    }) {
                        Text("Cancel")
                        
                    },
                trailing:
                    Button(action: {
                        dismiss()
                        if let selectedResult = selectedResult {
                            vm.updateResult(resultNumber: selectedResult.number, newResult: vm.calculateMilliseconds(hour: hoursSelection, minute: minutesSelection, second: secondsSelection, millisecond: millisecondsSelection), onSave: true)
                        }
                        vm.saveResults(training: training, goal: goal)
                        vm.todayResultFilter = .medium
                    }) {
                        Text("Save")
                    })
        }
        .interactiveDismissDisabled()
        .onAppear {
            //print("on appear for results today training \(training)")
            vm.getResultFromTodayTraining(for: training)
            if !vm.selectedResultsToday.isEmpty {
                selectedResult = vm.selectedResultsToday.first
            }
        }
        .onChange(of: selectedResult) { result in
            //print("result number: \(result?.number)")
            if let result = result {
                vm.updateResult(resultNumber: result.number, newResult: vm.calculateMilliseconds(hour: hoursSelection, minute: minutesSelection, second: secondsSelection, millisecond: millisecondsSelection), onSave: false)
                hoursSelection = 0
                minutesSelection = 0
                secondsSelection = 0
                millisecondsSelection = 0
            }
        }
    }
}

struct HalfModalTodayView_Previews: PreviewProvider {
    static let manager = CoreDataManager.instance
    static var previews: some View {
        ResultInputTodayView(presentationDetents: .constant(.medium), goal: GoalEntity(context: manager.context), training: TrainingEntity(context: manager.context))
            .environmentObject(MainViewModel())
    }
}
