import SwiftData
import SwiftUI

struct PantryItemEditorView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    private let item: PantryItem?

    @State private var name: String
    @State private var category: PantryCategory
    @State private var quantity: Int
    @State private var expirationDate: Date
    @State private var notes: String

    init(item: PantryItem? = nil) {
        self.item = item
        _name = State(initialValue: item?.name ?? "")
        _category = State(initialValue: item?.category ?? .other)
        _quantity = State(initialValue: item?.quantity ?? 1)
        _expirationDate = State(initialValue: item?.expirationDate ?? .now)
        _notes = State(initialValue: item?.notes ?? "")
    }

    private var trimmedName: String {
        name.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Item") {
                    TextField("Name", text: $name)
                        .textInputAutocapitalization(.words)
                        .accessibilityHint("Required")

                    Picker("Category", selection: $category) {
                        ForEach(PantryCategory.allCases) { category in
                            Label(category.rawValue, systemImage: category.symbolName)
                                .tag(category)
                        }
                    }

                    Stepper("Quantity: \(quantity)", value: $quantity, in: 1...99)
                }

                Section("Expiration") {
                    DatePicker(
                        "Expiration date",
                        selection: $expirationDate,
                        displayedComponents: .date
                    )
                }

                Section("Notes") {
                    TextField("Optional notes", text: $notes, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle(item == nil ? "New item" : "Edit item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: save)
                        .disabled(trimmedName.isEmpty)
                }
            }
        }
    }

    private func save() {
        if let item {
            item.name = trimmedName
            item.category = category
            item.quantity = quantity
            item.expirationDate = expirationDate
            item.notes = notes.trimmingCharacters(in: .whitespacesAndNewlines)
        } else {
            let newItem = PantryItem(
                name: trimmedName,
                category: category,
                quantity: quantity,
                expirationDate: expirationDate,
                notes: notes.trimmingCharacters(in: .whitespacesAndNewlines)
            )
            modelContext.insert(newItem)
        }

        dismiss()
    }
}

#Preview {
    PantryItemEditorView()
        .modelContainer(SampleData.previewContainer)
}

