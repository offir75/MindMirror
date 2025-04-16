// Question.swift
// MindMirror
//
// Created by Offir Ariel on 14/04/2025.

import Foundation

struct Question: Codable, Identifiable {
    let id: String
    let prompt: String
    let options: [AnswerOption]

    var identity: String { id }
}
