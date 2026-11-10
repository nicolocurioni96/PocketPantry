import Foundation
import SwiftData

enum SampleData {
    static func items(relativeTo date: Date = .now, calendar: Calendar = .current) -> [PantryItem] {
        [
            PantryItem(
                name: "Oat milk",
                category: .dairy,
                quantity: 2,
                expirationDate: calendar.date(byAdding: .day, value: 2, to: date) ?? date,
                notes: "Keep refrigerated after opening."
            ),
            PantryItem(
                name: "Pasta",
                category: .grains,
                quantity: 3,
                expirationDate: calendar.date(byAdding: .month, value: 8, to: date) ?? date
            ),
            PantryItem(
                name: "Spinach",
                category: .fruitAndVegetables,
                quantity: 1,
                expirationDate: calendar.date(byAdding: .day, value: -1, to: date) ?? date
            )
        ]
    }

    @MainActor
    static var previewContainer: ModelContainer {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: PantryItem.self, configurations: configuration)
        items().forEach(container.mainContext.insert)
        return container
    }
}

