import Foundation

struct Payment: Identifiable, Codable {
    var id: String
    var orderId: String
    var amount: Double
    var status: PaymentStatus
    var paymentMethod: PaymentMethod
    var createdAt: Date
    var updatedAt: Date
    
    init(id: String = UUID().uuidString,
         orderId: String,
         amount: Double,
         status: PaymentStatus = .pending,
         paymentMethod: PaymentMethod,
         createdAt: Date = Date(),
         updatedAt: Date = Date()) {
        self.id = id
        self.orderId = orderId
        self.amount = amount
        self.status = status
        self.paymentMethod = paymentMethod
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

enum PaymentStatus: String, Codable {
    case pending = "待支付"
    case processing = "处理中"
    case completed = "支付成功"
    case failed = "支付失败"
}

enum PaymentMethod: String, Codable, CaseIterable {
    case wechat = "微信支付"
    case alipay = "支付宝"
    case creditCard = "信用卡"
} 