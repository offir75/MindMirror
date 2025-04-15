//
//  Array+Safe.swift
//  MindMirror
//
//  Created by Sinai Ariel on 14/04/2025.
//

extension Array {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
