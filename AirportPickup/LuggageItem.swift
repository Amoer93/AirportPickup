import Foundation
import SwiftUI

struct LuggageItem: Identifiable {
    let id: UUID = UUID()
    var type: LuggageType
    var count: Int
    var image: UIImage?
    var isChecked: Bool // 是否托运
}

enum LuggageType: String, CaseIterable, Identifiable {
    case carryOn = "手提行李"
    case small = "小箱"
    case medium = "中箱"
    case large = "大箱"
    case oversize = "超大行李"

    var id: String { self.rawValue }
} 