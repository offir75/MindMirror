import SwiftUI

struct QuestionView: View {
    let question: Question
    let onAnswerSelected: (AnswerOption) -> Void

    @Namespace private var animation
    @State private var selectedOption: AnswerOption? = nil
    @State private var animateToFullScreen = false

    var body: some View {
        ZStack {
            if let selected = selectedOption {
                getColor(for: selected.text)
                    .ignoresSafeArea()
                    .zIndex(0)

                VStack {
                    if animateToFullScreen {
                        fullScreenBlock(for: selected)
                            .matchedGeometryEffect(id: selected.id, in: animation)
                            .onAppear {
                                // Move to next question after short delay
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                    onAnswerSelected(selected)
                                    // Reset animation state for the next question
                                    selectedOption = nil
                                    animateToFullScreen = false
                                }
                            }
                    }
                }
                .zIndex(1)

            } else {
                VStack(spacing: 16) {
                    Text(question.text)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding()

                    Spacer()

                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            optionBlock(question.options[safe: 0])
                            optionBlock(question.options[safe: 1])
                        }
                        HStack(spacing: 0) {
                            optionBlock(question.options[safe: 2])
                            optionBlock(question.options[safe: 3])
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                    Spacer()
                }
            }
        }
        .animation(.easeInOut(duration: 0.5), value: animateToFullScreen)
    }

    private func optionBlock(_ option: AnswerOption?) -> some View {
        Group {
            if let option = option {
                Button {
                    selectedOption = option
                    animateToFullScreen = true
                } label: {
                    ZStack {
                        getColor(for: option.text)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .matchedGeometryEffect(id: option.id, in: animation)

                        VStack(spacing: 8) {
                            if let icon = option.icon {
                                Image(systemName: icon)
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                            Text(option.text)
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .padding()
                    }
                }
            } else {
                Color.clear
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func fullScreenBlock(for option: AnswerOption) -> some View {
        ZStack {
            getColor(for: option.text)
                .ignoresSafeArea()
            VStack(spacing: 8) {
                if let icon = option.icon {
                    Image(systemName: icon)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                Text(option.text)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
            }
        }
    }

    private func getColor(for text: String) -> Color {
        switch text.lowercased() {
        case "red": return .red
        case "blue": return .blue
        case "green": return .green
        case "yellow": return .yellow
        case "orange": return .orange
        case "banana": return .yellow
        case "grapes": return .purple
        case "green apple": return .green
        case "circle": return .indigo
        case "triangle": return .red
        case "square": return .gray
        case "spiral": return .teal
        default: return Color.accentColor
        }
    }
}
