import SwiftUI

struct EmptyPantryView: View {
    let isFiltering: Bool
    let addAction: () -> Void

    var body: some View {
        ContentUnavailableView {
            Label(
                isFiltering ? "No matching items" : "Your pantry is empty",
                systemImage: isFiltering ? "line.3.horizontal.decrease.circle" : "basket"
            )
        } description: {
            Text(isFiltering ? "Try another search or filter." : "Add an item to start tracking expiration dates.")
        } actions: {
            if !isFiltering {
                Button("Add item", action: addAction)
                    .buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    EmptyPantryView(isFiltering: false) {}
}

