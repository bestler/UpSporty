//
//  FinalGoal.swift
//  NegroniChallenge
//
//  Created by Matteo Fontana on 25/10/22.
//

import SwiftUI

struct FinalGoal: View {
    @EnvironmentObject var vm: MainViewModel
    let screenWidth  = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    @State private var date = Date()
    
    @ObservedObject var input = NumbersOnly()
    
    let spacingConstantPicker: CGFloat = 30
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    @State var milliseconds: Int = 0
    
    @State var hidePickerToggle: Bool = false
    @State var addFrameToggle: Bool = false
    
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
                    VStack(alignment: .leading){
                        Text("Set your final goal date")
                            .foregroundColor(Color("grayText"))
                            .font(.system(size: 14))
                            .bold()
                        HStack {
                            Image(systemName: "calendar")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                            DatePicker(
                                    "Start Date",
                                    selection: $vm.dueDate,
                                    displayedComponents: [.date]
                            )
                        }
                        .padding(20)
                        .background(Color("cardColor"))
                        .cornerRadius(20)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 25)
                    VStack(alignment: .leading){
                        Text("Set your final goal metrics to reach")
                            .foregroundColor(Color("grayText"))
                            .font(.system(size: 14))
                            .bold()
                        VStack{
                            HStack {
                                Image(systemName: "figure.stand.line.dotted.figure.stand")
                                    .resizable()
                                    .frame(width: 20, height: 16)
                                    .scaledToFill()
                                Text("Distance")
                                    .foregroundColor(Color("grayText"))
                                    .font(.system(size: 20))
                                Spacer()
                                NavigationStack {
                                    TextField("Mt", text: $vm.target)
                                        .keyboardType(.decimalPad)
                                    
                                        .disableAutocorrection(true)
                                        .multilineTextAlignment(.trailing)
                                        .foregroundColor(Color("blackText"))
                                        .font(.system(size: 20))
                                        .toolbar {
                                            ToolbarItem(placement: .keyboard) {
                                                Button("Done") {
                                                    
                                                }
                                            }
                                        }
                                }
                                /*TextField("Mt", text: $vm.target)
                                    .keyboardType(.decimalPad)
                                
                                    .disableAutocorrection(true)
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(Color("blackText"))
                                    .font(.system(size: 20))*/
                            }
                            .padding(.top, 10)
                            .padding(.bottom, 20)
                            HStack {
                                Image(systemName: "timer")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .scaledToFill()
                                    
                                Text("Time")
                                    .foregroundColor(Color("grayText"))
                                    .font(.system(size: 20))
                                Spacer()
                                Text("\(hours)h \(minutes)m \(seconds)s \(milliseconds)m")
                                    .foregroundColor(Color("blackText"))
                                    .font(.system(size: 20))
                                    .onTapGesture {
                                        withAnimation (.easeInOut(duration: 0.1))
                                            {
                                                hidePickerToggle.toggle()
                                                addFrameToggle.toggle()
                                        }
                                        
                                    }
                            }
                            GeometryReader { geometry in
                                HStack(spacing: 0){
                                    Picker(
                                        selection: $hours,
                                        label: Text("h"),
                                        content: {
                                            ForEach(0 ..< 25){ number in
                                                Text("\(number) h")
                                                    .tag("h")
                                            }
                                        })
                                    .pickerStyle(.wheel)
                                    .frame(width: geometry.size.width / 4, alignment: .center)
                                    .clipped()
                                    Picker(
                                        selection: $minutes,
                                        label: Text("m"),
                                        content: {
                                            ForEach(0 ..< 61){ number in
                                                Text("\(number) m")
                                                    .tag("h")
                                            }
                                        })
                                    .pickerStyle(.wheel)
                                    .frame(width: geometry.size.width / 4, alignment: .center)
                                    .clipped()
                                    Picker(
                                        selection: $seconds,
                                        label: Text("s"),
                                        content: {
                                            ForEach(0 ..< 61){ number in
                                                Text("\(number) s")
                                                    .tag("h")
                                            }
                                        })
                                    .pickerStyle(.wheel)
                                    .frame(width: geometry.size.width / 4, alignment: .center)
                                    .clipped()
                                    Picker(
                                        selection: $milliseconds,
                                        label: Text("m"),
                                        content: {
                                            ForEach(0 ..< 10){ number in
                                                Text("\(number) m")
                                                    .tag("h")
                                            }
                                        })
                                    .pickerStyle(.wheel)
                                    .frame(width: geometry.size.width / 4, alignment: .center)
                                    .clipped()
                                }
                            }
                            .opacity(hidePickerToggle ? 1 : 0)
                            
                        }
                        .frame(height: addFrameToggle ? 320 : 105 )
                        .padding(20)
                        .background(Color("cardColor"))
                        .cornerRadius(20)
                    }
                    .padding(.horizontal, 20)
                    Spacer()
                }
                
            }
            
        }
    }
}

struct FinalGoal_Previews: PreviewProvider {
    static var previews: some View {
        FinalGoal()
            .environmentObject(MainViewModel())
    }
}

class NumbersOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter { $0.isNumber }
            
            if value != filtered {
                value = filtered
            }
        }
    }
}

extension UIPickerView {
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: super.intrinsicContentSize.height)
    }
}
