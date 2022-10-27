//
//  TrainingResultRowView.swift
//  NegroniChallenge
//
//  Created by Nicola Rigoni on 26/10/22.
//

import SwiftUI

struct TrainingResultRowView: View {
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "checkmark")
                .font(.headline)
                .bold()
                .foregroundColor(.green)
            Text("Time: ")
                .font(.title)
                .foregroundColor(.secondary)
            Spacer()
            Text("1:30:20,8")
                .font(.title)
                .bold()
        }
        .padding([.top, .bottom])
    }
}

struct TrainingResultRowView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingResultRowView()
    }
}
