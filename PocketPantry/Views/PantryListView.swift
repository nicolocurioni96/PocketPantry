import SwiftData
import SwiftUI

struct PantryListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \PantryItem.expirationDate) private var items: [PantryItem]

    @State private var searchText = ""
    @State private var selectedStatus: ExpirationStatus = .all
    @State private var isPresentingEditor = false
    @State private var hasSeededSampleData = false

    private var filteredItems: [PantryItem] {
        items.filter { item in
            let matchesSearch = searchText.isEmpty ||
                item.name.localizedStandardContains(searchText) ||
                item.category.rawValue.localizedStandardContains(searchText)
            let matchesStatus = selectedStatus == .all || item.expirationStatus() == selectedStatus
            return matchesSearch && matchesStatus
        }
    }

    private var isFiltering: Bool {
        !searchText.isEmpty || selectedStatus != .all
    }

    var body: some View {
        NavigationStack {
            Group {
                if filteredItems.isEmpty {
                    EmptyPantryView(isFiltering: isFiltering) {
                        isPresentingEditor = true
                    }
                } else {
                    List {
                        ForEach(filteredItems) { item in
                            NavigationLink {
                                PantryItemDetailView(item: item)
                            } label: {
                                PantryItemRow(item: item)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Pocket Pantry")
            .searchable(text: $searchText, prompt: "Search items")
            .safeAreaInset(edge: .top, spacing: 0) {
                statusFilter
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isPresentingEditor = true
                    } label: {
                        Label("Add item", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentingEditor) {
                PantryItemEditorView()
            }
            .task {
                seedSampleDataIfNeeded()
            }
        }
    }

    private var statusFilter: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(ExpirationStatus.allCases) { status in
                    Button {
                        selectedStatus = status
                    } label: {
                        Label(status.rawValue, systemImage: status.symbolName)
                            .font(.subheadline.weight(.medium))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                selectedStatus == status ? status.color.opacity(0.18) : Color.secondary.opacity(0.1),
                                in: Capsule()
                            )
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(selectedStatus == status ? status.color : .primary)
                    .accessibilityAddTraits(selectedStatus == status ? .isSelected : [])
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
        .background(.bar)
    }

    private func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(filteredItems[index])
        }
    }

    private func seedSampleDataIfNeeded() {
        guard !hasSeededSampleData, items.isEmpty else { return }
        hasSeededSampleData = true
        SampleData.items().forEach(modelContext.insert)
    }
}

#Preview {
    PantryListView()
        .modelContainer(SampleData.previewContainer)
}

