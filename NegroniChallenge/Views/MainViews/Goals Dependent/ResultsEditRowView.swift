//
//  ResultsEditRowView.swift
//  NegroniChallenge
//
//  Created by Nicola Rigoni on 30/10/22.
//

import SwiftUI

struct ResultsEditRowView: View {
    let result: TrainingResultEntity
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "checkmark")
                .font(.headline)
                .bold()
                .foregroundColor(result.result != 0 ? .green : .gray)
            Text("Time: ")
                .font(.title)
                .foregroundColor(.secondary)
            Spacer()
            Text(result.result.asTimeFormatted())
                .font(.title)
                .bold()
        }
        .padding([.top, .bottom])
    }
}

struct ResultsEditView_Previews: PreviewProvider {
    static let manager = CoreDataManager.instance
    static var previews: some View {
        ResultsEditRowView(result: TrainingResultEntity(context: manager.context))
    }
}
