// SideMenuView.swift
import SwiftUI

struct SideMenuView: View {
    var onSelect: (MenuOption) -> Void

    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                Spacer(minLength: 60) // Push content below the notch/status bar

                ForEach(MenuOption.allCases, id: \.self) { option in
                    Button(action: {
                        onSelect(option)
                    }) {
                        Label(option.title, systemImage: option.icon)
                            .font(.body) // Smaller font
                            .foregroundColor(.primary)
                            .padding(.vertical, 8)
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            .frame(width: 250, alignment: .leading)
            .frame(maxHeight: .infinity)
            .background(Color(UIColor.systemGroupedBackground))

            Spacer() // Pushes menu to the left
        }
        .edgesIgnoringSafeArea(.all)
    }
}

enum MenuOption: CaseIterable {
    case profile, retake, reset

    var title: String {
        switch self {
        case .profile: return "View Profile"
        case .retake: return "Retake Quiz"
        case .reset: return "Reset Profile"
        }
    }

    var icon: String {
        switch self {
        case .profile: return "person.crop.circle"
        case .retake: return "arrow.clockwise"
        case .reset: return "trash"
        }
    }
}

// Integration into MindMirrorView
struct MindMirrorView: View {
    @StateObject private var profile = UserProfile()
    @State private var currentQuestionIndex = 0
    @State private var showResult = false
    @State private var questions: [Question] = []
    @State private var showMenu = false
    private let questionsPerSession = 5

    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    HStack {
                        Button(action: {
                            showMenu.toggle()
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .font(.title2)
                                .foregroundColor(.primary)
                                .padding()
                        }
                        Spacer()
                    }

                    if showResult {
                        VStack(spacing: 16) {
                            Text("Your Core Elements")
                                .font(.title)

                            ForEach(ProfileTrait.allCases, id: \.self) { trait in
                                if let value = profile.traits[trait] {
                                    HStack {
                                        Text(trait.rawValue.capitalized)
                                        Spacer()
                                        Text("\(value)")
                                    }
                                }
                            }

                            Button("Retake Quiz") {
                                resetQuiz()
                            }
                            .buttonStyle(.borderedProminent)
                            .padding(.top, 40)
                        }
                        .padding()
                    } else {
                        if !questions.isEmpty {
                            QuestionView(
                                question: questions[currentQuestionIndex],
                                onAnswerSelected: handleAnswer
                            )
                        } else {
                            ProgressView("Loading...")
                                .onAppear {
                                    resetQuiz()
                                }
                        }
                    }
                }
            }
            .disabled(showMenu)

            if showMenu {
                SideMenuView { option in
                    handleMenuSelection(option)
                    withAnimation {
                        showMenu = false
                    }
                }
                .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut, value: showMenu)
    }

    private func handleAnswer(_ option: AnswerOption) {
        profile.apply(option: option)
        goToNextQuestion()
    }

    private func goToNextQuestion() {
        if currentQuestionIndex + 1 < questions.count {
            currentQuestionIndex += 1
        } else {
            showResult = true
        }
    }

    private func resetQuiz() {
        profile.reset()
        currentQuestionIndex = 0
        showResult = false
        questions = Array(QuestionBank.all.shuffled().prefix(questionsPerSession))
    }

    private func handleMenuSelection(_ option: MenuOption) {
        switch option {
        case .profile:
            showResult = true
        case .retake:
            resetQuiz()
        case .reset:
            profile.reset()
            currentQuestionIndex = 0
            showResult = true
            questions = []
        }
    }
}
