import Foundation
import SwiftData

@Model
final class PantryItem {
    var name: String
    var categoryRawValue: String
    var quantity: Int
    var expirationDate: Date
    var notes: String
    var createdAt: Date

    init(
        name: String,
        category: PantryCategory,
        quantity: Int,
        expirationDate: Date,
        notes: String = "",
        createdAt: Date = .now
    ) {
        self.name = name
        categoryRawValue = category.rawValue
        self.quantity = quantity
        self.expirationDate = expirationDate
        self.notes = notes
        self.createdAt = createdAt
    }

    var category: PantryCategory {
        get { PantryCategory(rawValue: categoryRawValue) ?? .other }
        set { categoryRawValue = newValue.rawValue }
    }

    func expirationStatus(
        relativeTo referenceDate: Date = .now,
        calendar: Calendar = .current
    ) -> ExpirationStatus {
        let startOfReference = calendar.startOfDay(for: referenceDate)
        let startOfExpiration = calendar.startOfDay(for: expirationDate)

        if startOfExpiration < startOfReference {
            return .expired
        }

        guard let warningDate = calendar.date(byAdding: .day, value: 3, to: startOfReference) else {
            return .fresh
        }

        return startOfExpiration <= warningDate ? .expiringSoon : .fresh
    }

    func daysUntilExpiration(
        relativeTo referenceDate: Date = .now,
        calendar: Calendar = .current
    ) -> Int {
        let startOfReference = calendar.startOfDay(for: referenceDate)
        let startOfExpiration = calendar.startOfDay(for: expirationDate)
        return calendar.dateComponents([.day], from: startOfReference, to: startOfExpiration).day ?? 0
    }
}

