import SwiftUI

struct MiniCheckInView: View {
    @Environment(\.dismiss) private var dismiss

    @StateObject private var engine = QuestionEngine()
    @State private var questions: [Question] = []
    @State private var currentIndex: Int = 0
    @State private var showResults = false

    private let miniSessionCount = 4

    // NEW: Optional callback to signal quiz is done
    var onFinished: (() -> Void)? = nil

    var body: some View {
        NavigationStack {
            VStack {
                if showResults {
                    VStack(spacing: 16) {
                        Text("Today's Energy ✨")
                            .font(.title2)

                        ForEach(Element.allCases, id: \.self) { element in
                            if let value = engine.score[element] {
                                HStack {
                                    Text(element.rawValue.capitalized)
                                    Spacer()
                                    Text("\(value)")
                                }
                                .padding(.horizontal)
                            }
                        }

                        Button("Done") {
                            dismiss()
                            onFinished?()
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.top, 24)
                    }
                    .padding()
                } else if currentIndex < questions.count {
                    QuestionView(
                        question: questions[currentIndex],
                        onAnswerSelected: { selected in
                            engine.answerSelected(selected)
                            currentIndex += 1

                            if currentIndex >= questions.count {
                                showResults = true
                            }
                        }
                    )
                } else {
                    ProgressView("Preparing your check-in...")
                        .onAppear {
                            loadMiniSession()
                        }
                }
            }
            .navigationTitle("Check-In")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                        onFinished?()
                    }
                }
            }
        }
    }

    private func loadMiniSession() {
        let all = engine.allQuestions
        questions = Array(all.shuffled().prefix(miniSessionCount))
    }
}
