//
//  MiniResultsView.swift
//  MindMirror
//
//  Created by Sinai Ariel on 16/04/2025.
//

import SwiftUI

struct MiniResultsView: View {
    let score: [Element: Int]
    let onDone: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Check-In Complete")
                .font(.title)
                .bold()

            VStack(spacing: 10) {
                ForEach(Element.allCases, id: \.self) { element in
                    HStack {
                        Text(element.rawValue.capitalized)
                        Spacer()
                        Text("\(score[element, default: 0])")
                    }
                    .padding(.horizontal)
                }
            }

            Button("Done") {
                onDone()
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 20)
        }
        .padding()
    }
}
