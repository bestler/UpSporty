//
//  ActivitySelectionView.swift
//  Test 25
//
//  Created by Matteo Fontana on 21/10/22.
//

import SwiftUI


struct ActivitySelectionView: View {
    @EnvironmentObject var vm: MainViewModel
    @State private var searchText = ""
    
    
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
                                        .overlay(vm.selectedSport == sportInstance.id ?
                                            RoundedRectangle(cornerRadius: 20)
                                            .stroke(sportInstance.sportColor, lineWidth: 4)
                                            :
                                            nil
                                        )
                                    VStack(alignment: .center){
                                        Image(systemName: sportInstance.sportIcon)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 40, height: 40)
                                            .foregroundColor(sportInstance.sportColor)
                                            .padding(.top, 28)
                                            //.font(.system(size: 45))
                                        Spacer()
                                        Text("\(sportInstance.sportName.rawValue)")
                                            .foregroundColor(Color("blackText"))
                                            .font(.system(size: 14, weight: .medium, design: .rounded))
                                            .padding(.bottom, 12)
                                    }
                                }
                                .onTapGesture {
                                    vm.selectedSport = Int16(sportInstance.id)
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
        ActivitySelectionView()
            .environmentObject(MainViewModel())
        
        
    }
}
