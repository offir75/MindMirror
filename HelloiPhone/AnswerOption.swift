//
//  AnswerOption.swift
//  MindMiror
//
//  Created by Offir Ariel on 14/04/2025.
//

import Foundation

struct ChoiceOption: Identifiable, Codable {
    let id: UUID
    let label: String
    let elementScores: [Element: Int]
    let positionHint: String?
}

