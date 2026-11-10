import SwiftUI

struct ExpirationBadge: View {
    let status: ExpirationStatus

    var body: some View {
        Label(status.rawValue, systemImage: status.symbolName)
            .font(.caption.weight(.semibold))
            .foregroundStyle(status.color)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(status.color.opacity(0.12), in: Capsule())
            .accessibilityElement(children: .combine)
    }
}

#Preview {
    VStack {
        ExpirationBadge(status: .fresh)
        ExpirationBadge(status: .expiringSoon)
        ExpirationBadge(status: .expired)
    }
}

