//
//  FinalGoal.swift
//  NegroniChallenge
//
//  Created by Matteo Fontana on 25/10/22.
//

import SwiftUI

struct FinalGoal: View {
    
    let screenWidth  = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
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
                            .font(.system(size: 16))
                            .bold()
                        VStack{
                            Text("fuibfriubfvr")
                                .foregroundColor(Color("blackText"))
                                .font(.system(size: 26))
                            Text("fuibfriubfvr")
                                .foregroundColor(Color("blackText"))
                                .font(.system(size: 26))
                        }
                        .frame(width: screenWidth - 90, height: 40)
                        .padding(20)
                        .background(Color("cardColor"))
                        .cornerRadius(20)
                    }
                    VStack(alignment: .leading){
                        Text("Set your final goal metrics to reach")
                            .foregroundColor(Color("grayText"))
                            .font(.system(size: 16))
                            .bold()
                        VStack{
                            HStack {
                                Text("Distance")
                                    .foregroundColor(Color("grayText"))
                                .font(.system(size: 20))
                                Spacer()
                                Text("fuibfriubfvr")
                                    .foregroundColor(Color("blackText"))
                                .font(.system(size: 26))
                            }
                            HStack {
                                Text("Time")
                                    .foregroundColor(Color("grayText"))
                                .font(.system(size: 16))
                                Spacer()
                                Text("fuibfriubfvr")
                                    .foregroundColor(Color("blackText"))
                                .font(.system(size: 26))
                            }
                            
                        }
                        .frame(width: screenWidth - 90, height: 40)
                        .padding(20)
                        .background(Color("cardColor"))
                        .cornerRadius(20)
                    }
                    Spacer()
                }
                
            }
            
        }
    }
}

struct FinalGoal_Previews: PreviewProvider {
    static var previews: some View {
        FinalGoal()
    }
}
