import Foundation

struct Driver: Identifiable, Equatable {
    var id: String
    var name: String
    var nationality: String
    var orderCount: Int
    var carTypes: [String]
    var rating: Double
    var avatar: String? // 头像URL或系统图片名
}

let sampleDrivers: [Driver] = [
    Driver(id: "1", name: "王伟", nationality: "中国", orderCount: 120, carTypes: ["丰田凯美瑞"], rating: 4.8, avatar: nil),
    Driver(id: "2", name: "John Smith", nationality: "澳大利亚", orderCount: 95, carTypes: ["本田雅阁", "特斯拉Model 3"], rating: 4.6, avatar: nil),
    Driver(id: "3", name: "佐藤健", nationality: "日本", orderCount: 80, carTypes: ["日产天籁"], rating: 4.9, avatar: nil)
] 