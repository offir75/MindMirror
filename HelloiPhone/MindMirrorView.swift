//
//  MindMirrorView.swift
//  MindMirror
//
//  Created by Sinai Ariel on 16/04/2025.
//

import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

struct MindMirrorView: View {
    @StateObject private var engine = QuestionEngine()
    @State private var showMenu = false
    @State private var showMiniCheckIn = false

    var body: some View {
        
        let _ = print("📍 MindMirrorView loaded. isFirstTime = \(engine.isFirstTime)")

        ZStack(alignment: .topLeading) {
            NavigationStack {
                VStack {
                    if engine.isFirstTime {
                        // Full onboarding quiz
                        if let question = engine.currentQuestion {
                            QuestionView(
                                question: question,
                                onAnswerSelected: { option in
                                    engine.answerSelected(option)
                                }
                            )
                        } else {
                            fullResultsView
                        }
                    } else {
                        // Returning user → welcome + mini check-in
                        WelcomeBackView {
                            showMiniCheckIn = true
                        }
                    }
                }
                .navigationTitle("Unfold")
                #if os(iOS)
                .navigationBarHidden(true)
                #endif
            }
            .disabled(showMenu)

            hamburgerIcon
            sideMenuOverlay
        }
        .fullScreenCover(isPresented: $showMiniCheckIn) {
            MiniCheckInView()
        }
        .animation(.easeInOut, value: showMenu)
    }

    private var fullResultsView: some View {
        VStack(spacing: 16) {
            Text("Your Core Elements")
                .font(.title)

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

            Button("Retake Quiz") {
                engine.reset()
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 20)
        }
        .padding()
    }

    private var hamburgerIcon: some View {
        VStack {
            HStack {
                Button(action: {
                    withAnimation {
                        showMenu = true
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .font(.title3)
                        .foregroundColor(.primary)
                        .padding(8)
                }
                Spacer()
            }
            Spacer()
        }
        .padding(.top, 8)
        .padding(.leading, 12)
        .zIndex(999)
    }

    private var sideMenuOverlay: some View {
        Group {
            if showMenu {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            showMenu = false
                        }
                    }

                HStack(spacing: 0) {
                    SideMenuView { option in
                        handleMenuSelection(option)
                        withAnimation {
                            showMenu = false
                        }
                    }
                    Spacer()
                }
                .transition(.move(edge: .leading))
            }
        }
    }

    private func handleMenuSelection(_ option: MenuOption) {
        switch option {
        case .profile:
            break
        case .retake:
            engine.reset()
        case .reset:
            engine.reset()
        }
    }
}
