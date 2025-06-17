// OrderDetailView.swift
import SwiftUI
import UIKit
import CoreLocation

struct OrderDetailView: View {
    let order: Order
    @Binding var orders: [Order]
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        List {
            Section(header: Text("订单信息")) {
                InfoRow(title: "订单编号", value: order.id)
                InfoRow(title: "用户ID", value: order.userId)
                InfoRow(title: "接送地点", value: order.pickupLocation)
                if let flight = order.flightInfo, !flight.isEmpty {
                    InfoRow(title: "航班号", value: flight)
                }
                InfoRow(title: "目的地", value: order.dropoffLocation)
                InfoRow(title: "接送时间", value: order.pickupTime.formatted())
                InfoRow(title: "乘客人数", value: "\(order.passengerCount)")
                InfoRow(title: "行李数量", value: "\(order.luggageCount)")
                InfoRow(title: "订单金额", value: "¥\(String(format: "%.2f", order.totalAmount))")
                InfoRow(title: "订单状态", value: order.status.rawValue)
            }
            Section(header: Text("司机")) {
                if let driver = sampleDrivers.first(where: { $0.id == order.driverId }) {
                    DriverInfoCell(driver: driver)
                }
            }
            if order.status != .cancelled {
                Section {
                    Button("取消订单") {
                        cancelOrder()
                    }
                    .foregroundColor(.red)
                }
            }
        }
        .navigationTitle("订单详情")
    }

    private func cancelOrder() {
        if let idx = orders.firstIndex(where: { $0.id == order.id }) {
            var updated = orders[idx]
            updated.status = .cancelled
            orders[idx] = updated
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct InfoRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundColor(.gray)
        }
    }
}

struct DriverInfoCell: View {
    let driver: Driver
    var body: some View {
        HStack(spacing: 16) {
            if let avatar = driver.avatar {
                Image(avatar)
                    .resizable()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 48, height: 48)
                    .foregroundColor(.gray)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(driver.name)
                    .font(.headline)
                Text("国籍：\(driver.nationality)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("接单量：\(driver.orderCount)")
                    .font(.caption)
                Text("车型：\(driver.carTypes.joined(separator: ", "))")
                    .font(.caption)
                HStack(spacing: 2) {
                    ForEach(1...5, id: \.self) { i in
                        Image(systemName: i <= Int(driver.rating.rounded()) ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                    }
                    Text(String(format: "%.1f", driver.rating))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            OrderDetailView(order: Order.sampleOrder, orders: .constant([Order.sampleOrder]))
        }
    }
}
