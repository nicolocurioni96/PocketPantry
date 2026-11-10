import SwiftData
import SwiftUI

@main
struct PocketPantryApp: App {
    var body: some Scene {
        WindowGroup {
            PantryListView()
        }
        .modelContainer(for: PantryItem.self)
    }
}

