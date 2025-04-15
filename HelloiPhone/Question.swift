enum QuestionType: String, Codable {
    case binary
    case multipleChoice
    case slider
}

struct AnswerOption: Identifiable, Codable {
    let id: UUID
    let label: String       // emoji, color, or short word
    let elementScores: [Element: Int]
    let positionHint: String? // Optional: "topLeft", "bottomRight" — for UI randomness
}

struct Question: Identifiable, Codable {
    let id: UUID
    let type: QuestionType
    let prompt: String
    let options: [AnswerOption]      // used for binary and multipleChoice
    let sliderLabels: (String, String)? // only for slider
    let elementMapForSlider: ((Double) -> [Element: Int])? // function-like logic for scale
    let tags: [String]?
    let nextQuestionIdByAnswer: [UUID: UUID]? // optional for branching logic
}
