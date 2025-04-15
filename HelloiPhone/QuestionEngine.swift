//
//  QuestionEngine.swift
//  MindMirror
//
//  Created by Sinai Ariel on 16/04/2025.
//

class QuestionEngine: ObservableObject {
    @Published var currentQuestion: Question
    @Published var history: [Question] = []
    @Published var score: [Element: Int] = [:]

    private var questionBank: [Question]

    init(questionBank: [Question]) {
        self.questionBank = questionBank.shuffled()
        self.currentQuestion = questionBank.first!
    }

    func answerSelected(_ option: AnswerOption) {
        history.append(currentQuestion)
        option.elementScores.forEach { score[$0.key, default: 0] += $0.value }

        if let nextId = currentQuestion.nextQuestionIdByAnswer?[option.id],
           let next = questionBank.first(where: { $0.id == nextId }) {
            currentQuestion = next
        } else {
            currentQuestion = getNextRandomQuestion()
        }
    }

    func goBack() {
        guard let last = history.popLast() else { return }
        currentQuestion = last
    }

    private func getNextRandomQuestion() -> Question {
        let remaining = questionBank.filter { !history.contains($0) }
        return remaining.randomElement() ?? currentQuestion
    }
}
