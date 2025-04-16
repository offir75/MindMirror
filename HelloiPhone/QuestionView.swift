import SwiftUI

struct QuestionView: View {
    let question: Question
    let onAnswerSelected: (AnswerOption) -> Void

    @Namespace private var animation
    @State private var selectedOption: AnswerOption? = nil
    @State private var animateToFullScreen = false

    var body: some View {
        let shuffledOptions = question.options.shuffled()

        ZStack {
            if let selected = selectedOption {
                getColor(for: selected.label)
                    .ignoresSafeArea()
                    .zIndex(0)

                VStack {
                    if animateToFullScreen {
                        fullScreenBlock(for: selected)
                            .matchedGeometryEffect(id: selected.id, in: animation)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                    onAnswerSelected(selected)
                                    selectedOption = nil
                                    animateToFullScreen = false
                                }
                            }
                    }
                }
                .zIndex(1)

            } else {
                VStack(spacing: 16) {
                    Text(question.prompt)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(.top, 48)

                    Spacer()

                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            optionBlock(shuffledOptions[safe: 0])
                            optionBlock(shuffledOptions[safe: 1])
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
                Button(action: {
                    selectedOption = option
                    animateToFullScreen = true
                }) {
                    ZStack {
                        getColor(for: option.label)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .matchedGeometryEffect(id: option.id, in: animation)

                        VStack(spacing: 8) {
                            Text(option.emoji)
                                .font(.largeTitle)
                            Text(option.label)
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .padding()
                    }
                }
            } else {
                Color.clear
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }

    private func fullScreenBlock(for option: AnswerOption) -> some View {
        ZStack {
            getColor(for: option.label)
                .ignoresSafeArea()

            VStack(spacing: 8) {
                Text(option.emoji)
                    .font(.system(size: 60))
                Text(option.label)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
            }
        }
    }

    private func getColor(for text: String) -> Color {
        switch text.lowercased() {
        case "sunrise": return .orange
        case "moonlight": return .blue
        case "movement": return .red
        case "ideas": return .purple
        case "your heart": return .teal
        case "your space": return .brown
        case "a torch": return .red
        case "a chisel": return .gray
        case "wind through trees": return .cyan
        case "ocean’s pull": return .indigo
        case "ritual": return .green
        case "vulnerability": return .mint
        case "the unknown": return .red
        case "losing control": return .blue
        case "silence": return .gray
        case "dreams": return .yellow
        case "wonder": return .purple
        case "forward": return .orange
        case "inward": return .blue
        default: return Color.accentColor
        }
    }
}
