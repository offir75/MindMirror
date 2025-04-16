import Foundation

class UserProfile: ObservableObject {
    @Published var elementScores: [Element: Int] = [:]

    func apply(option: AnswerOption) {
        for (element, value) in option.resolvedScores {
            elementScores[element, default: 0] += value
        }
    }

    func reset() {
        elementScores.removeAll()
    }
}

extension UserDefaults {
    var hasCompletedInitialQuiz: Bool {
        get { bool(forKey: "hasCompletedInitialQuiz") }
        set { set(newValue, forKey: "hasCompletedInitialQuiz") }
    }
}
