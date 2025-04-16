import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

// MARK: - Side Menu
struct SideMenuView: View {
    var onSelect: (MenuOption) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Spacer(minLength: 60)

            ForEach(MenuOption.allCases, id: \.self) { option in
                Button(action: {
                    onSelect(option)
                }) {
                    Label(option.title, systemImage: option.icon)
                        .font(.body)
                        .foregroundColor(.primary)
                        .padding(.vertical, 8)
                }
            }

            Spacer()
        }
        .padding(.horizontal)
        .frame(width: 250, alignment: .leading)
        .frame(maxHeight: .infinity)
        .background(
            Group {
                #if canImport(UIKit)
                Color(UIColor.systemGroupedBackground)
                #else
                Color.gray.opacity(0.2)
                #endif
            }
        )
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
