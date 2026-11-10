import Foundation

enum PantryCategory: String, CaseIterable, Codable, Identifiable {
    case bakery = "Bakery"
    case beverages = "Beverages"
    case cannedGoods = "Canned goods"
    case dairy = "Dairy"
    case frozen = "Frozen"
    case fruitAndVegetables = "Fruit and vegetables"
    case grains = "Grains"
    case other = "Other"
    case snacks = "Snacks"

    var id: String { rawValue }

    var symbolName: String {
        switch self {
        case .bakery: "takeoutbag.and.cup.and.straw"
        case .beverages: "waterbottle"
        case .cannedGoods: "shippingbox"
        case .dairy: "cup.and.saucer.fill"
        case .frozen: "snowflake"
        case .fruitAndVegetables: "carrot"
        case .grains: "leaf"
        case .other: "square.grid.2x2"
        case .snacks: "popcorn"
        }
    }
}

