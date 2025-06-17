// Order.swift
import Foundation

struct Order: Identifiable, Codable {
    var id: String
    var userId: String
    var driverId: String
    var pickupLocation: String
    var dropoffLocation: String
    var pickupTime: Date
    var passengerCount: Int
    var luggageCount: Int
    var totalAmount: Double
    var status: OrderStatus
    var createdAt: Date
    var updatedAt: Date
    var flightInfo: String?

    init(id: String = UUID().uuidString,
         userId: String,
         driverId: String = "driver_1",
         pickupLocation: String,
         dropoffLocation: String,
         pickupTime: Date,
         passengerCount: Int,
         luggageCount: Int,
         totalAmount: Double,
         status: OrderStatus = .pending,
         createdAt: Date = Date(),
         updatedAt: Date = Date(),
         flightInfo: String? = nil) {
        self.id = id
        self.userId = userId
        self.driverId = driverId
        self.pickupLocation = pickupLocation
        self.dropoffLocation = dropoffLocation
        self.pickupTime = pickupTime
        self.passengerCount = passengerCount
        self.luggageCount = luggageCount
        self.totalAmount = totalAmount
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.flightInfo = flightInfo
    }
    
    // 示例订单
    static var sampleOrder: Order {
        Order(
            userId: "test_user",
            pickupLocation: "Melbourne T1",
            dropoffLocation: "墨尔本市中心",
            pickupTime: Date().addingTimeInterval(3600),
            passengerCount: 2,
            luggageCount: 3,
            totalAmount: 299.00,
            status: .completed,
            flightInfo: "MU5735"
        )
    }
}

enum OrderStatus: String, Codable {
    case pending = "待支付"
    case inProgress = "进行中"
    case completed = "已完成"
    case cancelled = "已取消"
}
