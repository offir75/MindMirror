// AnswerOption.swift
// MindMirror
//
// Created by Offir Ariel on 14/04/2025.

import Foundation

struct AnswerOption: Identifiable, Hashable, Codable {
    let id = UUID()
    let label: String
    let emoji: String
    let elementScores: [String: Int]
    let next: String

    var resolvedScores: [Element: Int] {
        elementScores.compactMap { key, value in
            Element(rawValue: key).map { ($0, value) }
        }
        .reduce(into: [:]) { $0[$1.0, default: 0] += $1.1 }
    }
}
