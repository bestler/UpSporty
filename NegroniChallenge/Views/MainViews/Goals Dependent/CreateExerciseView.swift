//
//  CreateExerciseView.swift
//  NegroniChallenge
//
//  Created by Simon Bestler on 26.10.22.
//

import SwiftUI

struct CreateExerciseView: View {
    
    @State private var dueDate = Date()
    @State private var isExercise = true;
    
    var body: some View {
        ZStack{
            Color("mainBackground")
                .ignoresSafeArea()
            VStack{
                Text("Create a new Training")
                    .foregroundColor(Color("blackText"))
                    .font(.system(size: 26))
                    .padding(.top, 15)
                    .bold()
                Text("You can choose between a casual exercise or an assesment")
                    .foregroundColor(Color("blackText"))
                    .padding(.top, 1)
                    .font(.system(size: 18))
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.center)
                VStack(alignment: .leading){
                    Text("Set the type of training")
                        .foregroundColor(Color("grayText"))
                        .font(.system(size: 14))
                        .bold()
                    HStack {
                        Image(systemName: "list.bullet")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                        Text("Type of training")
                        Spacer()
                        Picker(selection: $isExercise, label: Text("Select for type of training")) {
                            Text("Exercise").tag(true)
                            Text("Assesment").tag(false)
                        }
                        
                    }
                    .padding(20)
                    .background(Color("cardColor"))
                    .cornerRadius(20)
                    //TODO: Provide a description of what the difference is
                }.padding(.bottom, 20).padding(.horizontal, 20)
                VStack(alignment: .leading){
                    Text("Set the date of the training")
                        .foregroundColor(Color("grayText"))
                        .font(.system(size: 14))
                        .bold()
                    HStack {
                        Image(systemName: "calendar")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                        DatePicker(
                            "Training Date",
                            selection: $dueDate,
                            displayedComponents: [.date]
                        )
                    }
                    .padding(20)
                    .background(Color("cardColor"))
                    .cornerRadius(20)
                    Spacer()
                }.padding(.horizontal, 20)
            }
            
        }
        
    }
}

struct CreateExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        CreateExerciseView()
    }
}
