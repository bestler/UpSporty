//
//  ActivitySelection.swift
//  Test 25
//
//  Created by Matteo Fontana on 21/10/22.
//

import SwiftUI


struct ActivitySelection: View {
    @EnvironmentObject var vm: MainViewModel
    
    //@State var sportSelectionArrayCopy = sportSelectionArray
    @State private var searchText = ""
    @State var isActivitySelected: Bool = false
    
    private let numberColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    let screenWidth  = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("mainBackground")
                    .ignoresSafeArea()
                VStack {
                    Text("Select Activity")
                        .foregroundColor(Color("blackText"))
                        .font(.system(size: 26))
                        .padding(.top, 15)
                        .bold()
                    Text("Select the sport of your new goal")
                        .foregroundColor(Color("blackText"))
                        .font(.system(size: 16))
                    ScrollView {
                        LazyVGrid(columns: numberColumns, spacing: 20){
                            ForEach(searchResults) { sportInstance in
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(Color("cardColor"))
                                        .cornerRadius(20)
                                        .overlay( isActivitySelected ?
                                            RoundedRectangle(cornerRadius: 20)
                                            .stroke(sportInstance.sportColor, lineWidth: 4)
                                            :
                                            nil
                                        )
                                    VStack {
                                        Image(systemName: sportInstance.sportIcon)
                                            .foregroundColor(sportInstance.sportColor)
                                            .font(.system(size: 45))
                                        Text("\(sportInstance.sportName.rawValue)")
                                            .foregroundColor(Color("blackText"))
                                            .font(.system(size: 14, weight: .medium, design: .rounded))
                                    }
                                }
                                .onTapGesture {
                                    isActivitySelected.toggle()
                                }
                                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                                .frame(width: screenWidth/3-21, height: screenWidth/3-21)
                            }
                        }
                        .padding()
                    }
                }
                
            }
            .searchable(text: $searchText, prompt: "Search")
            /*.onChange(of: searchText){ sportInstance in
                if !sportInstance.isEmpty {
                    sportSelectionArrayCopy = sportSelectionArray.filter {
                        $0.sportName.contains(sportInstance)}
                } else {
                    sportSelectionArrayCopy = sportSelectionArray
                }
            }*/
            /*.navigationBarTitle(Text("Activity Selection"), displayMode: .inline)*/
        }
    }
    
    var searchResults: [SportModel] {
           if searchText.isEmpty {
               return vm.allSports
           } else {
               return vm.allSports.filter { $0.sportName .rawValue.contains(searchText) }
           }
       }
    
    
}



struct ActivitySelection_Previews: PreviewProvider {
    static var previews: some View {
        ActivitySelection()
    }
}
