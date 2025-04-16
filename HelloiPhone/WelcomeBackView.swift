import SwiftUI

struct WelcomeBackView: View {
    var onTap: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome back! ☀️")
                .font(.title)
                .bold()
            Text("Let's check how you're feeling today.")
                .multilineTextAlignment(.center)

            Button("Start Check-In") {
                onTap()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
