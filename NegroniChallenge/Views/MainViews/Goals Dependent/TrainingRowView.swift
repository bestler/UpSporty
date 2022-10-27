//
//  TrainingRowView.swift
//  NegroniChallenge
//
//  Created by Nicola Rigoni on 26/10/22.
//

import SwiftUI

struct TrainingRowView: View {
    var body: some View {
        VStack(spacing: 5) {
            Text("Today")
                .font(.caption)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack{
                VStack(alignment: .leading) {
                    Text("Exercise")
                        .font(.headline)
                    Text("Repeat")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
                .padding()
                .frame(maxWidth: .infinity, minHeight: 80, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
                )
        }
        
        
    }
}

struct TrainingRowView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            TrainingRowView()
        }
        
        
    }
}
