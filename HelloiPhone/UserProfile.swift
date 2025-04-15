//
//  UserProfile.swift
//  MindMiror
//
//  Created by Offir Ariel on 14/04/2025.
//

import Foundation
import SwiftUI

class UserProfile: ObservableObject {
    @Published var traits: [ProfileTrait: Int] = [:]

    func apply(option: AnswerOption) {
        for (trait, value) in option.effects {
            traits[trait, default: 0] += value
        }
    }

    func reset() {
        traits.removeAll()
    }
}
