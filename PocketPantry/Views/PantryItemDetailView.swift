import SwiftUI

struct PantryItemDetailView: View {
    let item: PantryItem
    @State private var isEditing = false

    private var status: ExpirationStatus {
        item.expirationStatus()
    }

    var body: some View {
        List {
            Section {
                VStack(spacing: 12) {
                    Image(systemName: item.category.symbolName)
                        .font(.system(size: 42))
                        .foregroundStyle(.tint)
                        .accessibilityHidden(true)

                    Text(item.name)
                        .font(.title2.bold())
                        .multilineTextAlignment(.center)

                    ExpirationBadge(status: status)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
            }

            Section("Details") {
                LabeledContent("Category", value: item.category.rawValue)
                LabeledContent("Quantity", value: item.quantity.formatted())
                LabeledContent("Expiration") {
                    Text(item.expirationDate, format: .dateTime.day().month(.wide).year())
                }
            }

            if !item.notes.isEmpty {
                Section("Notes") {
                    Text(item.notes)
                }
            }
        }
        .navigationTitle("Item details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Edit") { isEditing = true }
        }
        .sheet(isPresented: $isEditing) {
            PantryItemEditorView(item: item)
        }
    }
}

#Preview {
    NavigationStack {
        PantryItemDetailView(item: SampleData.items()[0])
    }
    .modelContainer(SampleData.previewContainer)
}

