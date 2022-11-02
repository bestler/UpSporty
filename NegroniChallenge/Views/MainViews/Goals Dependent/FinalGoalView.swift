//
//  FinalGoal.swift
//  NegroniChallenge
//
//  Created by Matteo Fontana on 25/10/22.
//

import SwiftUI

//DatePicker(
//        "Start Date",
//        selection: $vm.dueDate,
//        displayedComponents: [.date]
//)

struct FinalGoalView: View {
    @EnvironmentObject var vm: MainViewModel
    let screenWidth  = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    
    let spacingConstantPicker: CGFloat = 30
    @State private var hoursSelection = 0
    @State private var minutesSelection = 0
    @State private var secondsSelection = 0
    @State private var millisecondsSelection = 0
    
    @State var showPicker: Bool = false
    @State var addFrameToggle: Bool = false
    @FocusState var distanceInFocus: Bool
    private let hours = [Int](0..<24)
    private let minutes = [Int](0..<60)
    private let seconds = [Int](0..<60)
    private let milliseconds = [Int](0..<100)
    
    var body: some View {
        NavigationStack{
            
            ZStack{
                Color("mainBackground")
                    .ignoresSafeArea()
                VStack {
                    Text("Final Goal")
                        .foregroundColor(Color("blackText"))
                        .font(.system(size: 26))
                        .padding(.top, 15)
                        .bold()
                    Text("Select the metrics of your new goal")
                        .foregroundColor(Color("blackText"))
                        .padding(.top, 1)
                        .font(.system(size: 18))
                        .padding(.bottom, 35)
                    List {
                        Section("Select the goal date") {
                            HStack {
                                Image(systemName: "calendar")
                                Text("Date")
                                DatePicker(
                                    "",
                                    selection: $vm.dueDate,
                                    displayedComponents: [.date]
                                )

                            }
                            .padding([.top, .bottom], 3)
                        }
                        Section("Select the goal target") {
                            HStack {
                                Image(systemName: "figure.stand.line.dotted.figure.stand")
                                Text("Distance")
                                Spacer()
                                TextField("Mt", text: $vm.target)
                                    .keyboardType(.decimalPad)
                                    .disableAutocorrection(true)
                                    .multilineTextAlignment(.trailing)
                                    .focused($distanceInFocus)
                                    .foregroundColor(Color("blackText"))
                                    
                            }
                            .padding([.top, .bottom], 3)
                            
                            Button {
                                showPicker.toggle()
                                distanceInFocus = false
                            } label: {
                                HStack {
                                    Image(systemName: "stopwatch")
                                    Text("Time")
                                    Spacer()
                                    Text(vm.calculateMilliseconds(hour: vm.selectedHourPicker, minute: vm.selectedMinutePicker, second: vm.selectedSecondPicker, millisecond: vm.selectedMilliSecondPicker).asTimeFormatted())
                                }
                                .padding([.top, .bottom], 3)
                            }
                            .buttonStyle(.plain)

                            if showPicker {
                                VStack {
                                    Grid {
                                        GridRow {
                                            Text("h")
                                            Text("m")
                                            Text("s")
                                            Text("ms")
                                        }
                                        
                                        GridRow {
                                            Picker("", selection: $vm.selectedHourPicker) {
                                                ForEach(hours, id: \.self) { hour in
                                                    Text("\(hour)")
                                                }
                                            }
                                            .pickerStyle(.wheel)
                                            
                                            Picker("", selection: $vm.selectedMinutePicker) {
                                                ForEach(minutes, id: \.self) { minute in
                                                    Text("\(minute)")
                                                }
                                            }
                                            .pickerStyle(.wheel)
                                            
                                            Picker("", selection: $vm.selectedSecondPicker) {
                                                ForEach(seconds, id: \.self) { second in
                                                    Text("\(second)")
                                                }
                                            }
                                            .pickerStyle(.wheel)
                                            
                                            Picker("", selection: $vm.selectedMilliSecondPicker) {
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
                    .scrollDisabled(true)
                    .scrollContentBackground(.hidden)
                    
                }
            }
        }
    }
}

struct FinalGoal_Previews: PreviewProvider {
    static var previews: some View {
        FinalGoalView()
            .environmentObject(MainViewModel())
    }
}

extension UIPickerView {
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: super.intrinsicContentSize.height)
        
    }
    
}
