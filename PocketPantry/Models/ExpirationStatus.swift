import Foundation
import SwiftUI

enum ExpirationStatus: String, CaseIterable, Identifiable {
    case all = "All"
    case fresh = "Fresh"
    case expiringSoon = "Expiring soon"
    case expired = "Expired"

    var id: String { rawValue }

    var color: Color {
        switch self {
        case .all: .accentColor
        case .fresh: .green
        case .expiringSoon: .orange
        case .expired: .red
        }
    }

    var symbolName: String {
        switch self {
        case .all: "square.grid.2x2"
        case .fresh: "checkmark.circle"
        case .expiringSoon: "clock.badge.exclamationmark"
        case .expired: "exclamationmark.triangle"
        }
    }
}

