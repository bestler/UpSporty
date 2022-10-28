//
//  CreateTrainingView.swift
//  NegroniChallenge
//
//  Created by Simon Bestler on 26.10.22.
//

import SwiftUI

struct Training : Identifiable {
    var id : UUID = UUID()
    var dueDate : Date
    var isCompleted : Bool = false
    var isExercise: Bool
    var repeatCountTotal : Int16
    var target : Int16
}


struct EditTrainingSheetView: View {
    
    var trainings = [Training(dueDate: Date(timeIntervalSinceReferenceDate: -123456789.0), isExercise: true,  repeatCountTotal: 5, target: 2000), Training(dueDate:Date(),isExercise: false, repeatCountTotal: 0, target: 0)]
    
    @State private var isModalShown = false
    @State private var selectedTraining : Training? = nil
    
    var body: some View {
        
        
        ZStack {
            Color("mainBackground")
                .ignoresSafeArea()
            VStack {
                Text("Create your Training Sheet")
                    .foregroundColor(Color("blackText"))
                    .font(.system(size: 26))
                    .padding(.top, 15)
                    .bold()
                Text("Plan your training to reach your goal 📈!")
                    .foregroundColor(Color("blackText"))
                    .padding(.top, 1)
                    .font(.system(size: 18))
                    .padding(.bottom, 20)
                
                VStack(alignment: .leading){
                    HStack {
                        Image(systemName: "plus.circle")
                        Text("Crete new training")
                        Spacer()
                    }
                    .padding(20)
                    .background(Color("cardColor"))
                    .cornerRadius(20)
                    .onTapGesture {
                        isModalShown = true
                    }
                    .sheet(isPresented: $isModalShown){
                        EditTrainingView(training: selectedTraining)
                    }
                }.padding(.bottom, 20).padding(.horizontal, 20)
                HStack {
                    Text("Already Scheduled Trainings")
                        .foregroundColor(Color("grayText"))
                        .font(.system(size: 14))
                    .bold()
                    Spacer()
                }.padding(.horizontal, 20)
                
                ForEach(trainings) { training in
                    
                    
                    HStack {
                        if(training.isExercise){
                            Image(systemName: "note.text")
                            Text("Exercise \(training.repeatCountTotal) x \(training.target) m")
                            
                        }else {
                            Image(systemName: "flag")
                            Text("Assesment").bold()
                        }
                        Spacer()
                    }
                    .padding(20)
                    .background(Color("cardColor"))
                    .cornerRadius(20)
                    .padding(.horizontal, training.isExercise == true ? 20 : 0)
                    .onTapGesture {
                            selectedTraining = training
                            isModalShown = true
                    }
                }
                .padding(.horizontal, 20)
                Spacer()
            }
        }
        
    }
}

struct EditTrainingSheetView_Previews: PreviewProvider {
    static var previews: some View {
        EditTrainingSheetView()
    }
}
