//
//  ResultInputTodayView.swift
//  NegroniChallenge
//
//  Created by Matteo Fontana on 24/10/22.
//

import SwiftUI

struct ResultInputTodayView: View {
    
    @Binding var showHalfSheet: Bool
    
    @State var selectedStrenght: Int = 0
    
    let screenWidth  = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    @State var hoursSelection = 0
    @State var minutesSelection = 0
    @State var secondsSelection = 0
    var hours = [Int](0..<24)
    var minutes = [Int](0..<60)
    var seconds = [Int](0..<60)
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("mainBackground")
                    .ignoresSafeArea()
                HStack(spacing: 0) {
                    Picker(selection: self.$hoursSelection, label: Text("")) {
                        ForEach(0 ..< self.hours.count, id: \.self) { index in
                            Text("\(self.hours[index]) h").tag(index)
                        }
                    }
                    .pickerStyle(.wheel)
                    .fixedSize(horizontal: true, vertical: true)
                    .frame(width: screenWidth / 3, height: 160)
                    .compositingGroup()
                    .clipped()
                    Picker(selection: self.$minutesSelection, label: Text("")) {
                        ForEach(0 ..< self.minutes.count, id: \.self) { index in
                            Text("\(self.minutes[index]) m").tag(index)
                        }
                    }
                    .pickerStyle(.wheel)
                    .fixedSize(horizontal: true, vertical: true)
                    .frame(width: screenWidth / 3, height: 160)
                    .compositingGroup()
                    .clipped()
                    Picker(selection: self.$secondsSelection, label: Text("")) {
                        ForEach(0 ..< self.seconds.count, id: \.self) { index in
                            Text("\(self.seconds[index]) s").tag(index)
                        }
                    }
                    .pickerStyle(.wheel)
                    .labelsHidden()
                    .fixedSize(horizontal: true, vertical: true)
                    .frame(width: screenWidth / 3, height: 160)
                    .compositingGroup()
                    .clipped()
                }
                .frame(width: screenWidth - 20*2)
                
            }
            //.frame(width: screenWidth, height: screenWidth)
            .navigationBarTitle(Text("New Goal"), displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        showHalfSheet = false
                    }) {
                        Text("Cancel")
                        
                    },
                
                trailing:
                    Button(action: {
                        showHalfSheet = false
                    }) {
                        Text("Save").bold()
                    }
            )
        }
        
        .interactiveDismissDisabled()
    }
}

struct HalfModalTodayView_Previews: PreviewProvider {
    static var previews: some View {
        ResultInputTodayView(showHalfSheet: TodayView().$showHalfSheet)
    }
}
