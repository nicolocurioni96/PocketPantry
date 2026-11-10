import SwiftUI

struct PantryItemRow: View {
    let item: PantryItem

    private var status: ExpirationStatus {
        item.expirationStatus()
    }

    private var expirationDescription: String {
        switch item.daysUntilExpiration() {
        case let days where days < 0:
            "Expired \(abs(days)) day\(abs(days) == 1 ? "" : "s") ago"
        case 0:
            "Expires today"
        case 1:
            "Expires tomorrow"
        case let days:
            "Expires in \(days) days"
        }
    }

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: item.category.symbolName)
                .font(.title2)
                .foregroundStyle(.tint)
                .frame(width: 36, height: 36)
                .background(.tint.opacity(0.12), in: RoundedRectangle(cornerRadius: 10))
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 5) {
                HStack(alignment: .firstTextBaseline) {
                    Text(item.name)
                        .font(.headline)
                    Spacer()
                    Text("×\(item.quantity)")
                        .font(.subheadline.monospacedDigit())
                        .foregroundStyle(.secondary)
                }

                Text(item.category.rawValue)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                HStack {
                    Text(expirationDescription)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Spacer()
                    ExpirationBadge(status: status)
                }
            }
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(item.name), quantity \(item.quantity), \(item.category.rawValue)")
        .accessibilityValue("\(expirationDescription), status \(status.rawValue)")
    }
}

