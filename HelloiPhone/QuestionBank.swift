//
//  QuestionBank.swift
//  MindMirror
//
//  Created by Sinai Ariel on 14/04/2025.
//

import Foundation

struct QuestionBank {
    static let all: [Question] = [
        Question(
            text: "Pick a color",
            options: [
                AnswerOption(text: "Red", icon: "flame.fill", effects: [.fire: 2, .spontaneous: 1]),
                AnswerOption(text: "Blue", icon: "drop.fill", effects: [.water: 2, .logical: 1]),
                AnswerOption(text: "Green", icon: "leaf.fill", effects: [.earth: 2, .structured: 1]),
                AnswerOption(text: "Yellow", icon: "wind", effects: [.air: 2, .emotional: 1])
            ]
        ),
        Question(
            text: "Choose a fruit",
            options: [
                AnswerOption(text: "Banana", icon: "leaf", effects: [.earth: 1, .structured: 1]),
                AnswerOption(text: "Orange", icon: "sun.max.fill", effects: [.fire: 1, .spontaneous: 1]),
                AnswerOption(text: "Grapes", icon: "drop", effects: [.water: 2, .emotional: 1]),
                AnswerOption(text: "Green Apple", icon: "wind", effects: [.air: 2, .logical: 1])
            ]
        )
        // Add more later!
    ]
}
