import Foundation

class QuestionEngine: ObservableObject {
    @Published var currentQuestion: Question?
    @Published var score: [Element: Int] = [:]
    @Published var miniCheckInComplete = false

    private var questionMap: [String: Question] = [:]

    // MARK: - First Time Logic
    var isFirstTime: Bool {
        !UserDefaults.standard.bool(forKey: "hasCompletedInitialQuiz")
    }

    var allQuestions: [Question] {
        Array(questionMap.values)
    }

    init() {
        loadQuestions()
        currentQuestion = questionMap["Q1"]

        print("🧪 Initialized engine. Found Q1? \(currentQuestion != nil ? "✅ YES" : "❌ NO")")
    }

    // MARK: - Load from JSON
    private func loadQuestions() {
        guard let url = Bundle.main.url(forResource: "unfold_questions", withExtension: "json") else {
            print("❌ Could not find unfold_questions.json")
            return
        }

        print("✅ Found JSON at: \(url.path)")

        do {
            let data = try Data(contentsOf: url)
            print("✅ Loaded JSON data: \(data.count) bytes")

            let decoded = try JSONDecoder().decode([Question].self, from: data)
            print("✅ Decoded questions: \(decoded.map { $0.id })")

            questionMap = Dictionary(uniqueKeysWithValues: decoded.map { ($0.id, $0) })
        } catch {
            print("❌ Failed to decode questions: \(error)")
        }
    }

    // MARK: - Handle Answer
    func answerSelected(_ option: AnswerOption) {
        for (element, value) in option.resolvedScores {
            score[element, default: 0] += value
        }

        print("🔥 Score updated: \(score)")

        if option.next == "END" {
            if !isFirstTime {
                miniCheckInComplete = true
            }
            currentQuestion = nil
            print("🎉 Quiz complete. Marked as finished.")
        } else {
            currentQuestion = questionMap[option.next]
            print("➡️ Moved to question \(option.next)")
        }
    }

    // MARK: - Reset
    func reset() {
        score = [:]
        currentQuestion = questionMap["Q1"]
        UserDefaults.standard.set(false, forKey: "hasCompletedInitialQuiz")
        print("🔄 Reset quiz and cleared first-time flag.")
    }
}
