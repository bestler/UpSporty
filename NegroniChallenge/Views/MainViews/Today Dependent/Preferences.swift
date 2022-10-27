//
//  Preferences.swift
//  Test 25
//
//  Created by Matteo Fontana on 22/10/22.
//

import SwiftUI

struct Preferences: View {
    
    @Binding var showingSheet: Bool
    
    let screenWidth  = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    @AppStorage("selectedAppearance") var selectedAppearance = 0
    @State var utilities = Utilities()
    
    @State private var showingAlert = false
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color("mainBackground")
                    .ignoresSafeArea()
                VStack(alignment: .leading){
                    Text("Select View Preference Color:")
                        .foregroundColor(Color("grayText"))
                        .font(.system(size: 13))
                        .padding(.horizontal, 20)
                    HStack {
                        Spacer()
                        Button(action: {
                            selectedAppearance = 1
                        }) {
                            ZStack {
                                Color("cardColor")
                                    .ignoresSafeArea()
                                VStack{
                                    Image(systemName: "sun.min")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                    Text("Light")
                                }
                                .padding(10)
                            }
                            .frame(width: screenWidth / 3 - 20, height: screenWidth / 3 - 20)
                            .cornerRadius(20)
                        }
                        Button(action: {
                            selectedAppearance = 2
                        }) {
                            ZStack {
                                Color("cardColor")
                                VStack{
                                    Image(systemName: "moon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                    Text("Dark")
                                }
                                .padding(10)
                            }
                            .frame(width: screenWidth / 3 - 20, height: screenWidth / 3 - 20)
                            //.padding(20)
                            .cornerRadius(20)
                        }
                        Button(action: {
                            selectedAppearance = 0
                        }) {
                            ZStack {
                                Color("cardColor")
                                VStack{
                                    Image(systemName: "iphone.circle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                    Text("Auto")
                                }
                                .padding(10)
                            }
                            .frame(width: screenWidth / 3 - 20, height: screenWidth / 3 - 20)
                            //.padding(20)
                            .cornerRadius(20)
                        }
                        Spacer()
                    }
                    .onChange(of: selectedAppearance, perform: { value in
                        utilities.overrideDisplayMode()
                    })
                    .padding(.bottom, 20)
                    //Here Goes Other Conter
                    Text("Deletion of all datas in the App")
                        .foregroundColor(Color("grayText"))
                        .font(.system(size: 13))
                        .padding(.horizontal, 20)
                    Button(action: {
                        self.showingAlert.toggle()
                    }) {
                        Text("Delete All Data")
                            .font(.headline)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .frame(maxWidth: 300)
                    }
                    /*.alert(isPresented: self.$showingAlert) {
                                Alert(title: Text("Hello"))
                            }*/
                    .alert(isPresented: self.$showingAlert) { () -> Alert in
                        Alert(title: Text("Warning"), message: Text("This button deletes all the inserted data in the application, this process can't be undone, proceed?"), primaryButton: .default(Text("Cancel"), action: {
                            self.showingAlert.toggle()
                        }), secondaryButton: .destructive(Text("Delete")))}
                    .buttonStyle(.borderedProminent)
                    .frame(width: screenWidth + 20)
                    .tint(.red)
                    Spacer()
                }
                .padding(.top, 20)
            }
            .navigationBarTitle(Text("Preferences"), displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button{
                self.showingSheet.toggle()
            } label: {
                Text("Done")
                    .bold()
            })
        }
    }
}
