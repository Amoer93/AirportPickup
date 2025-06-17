// OrderListView.swift
import SwiftUI

struct OrderListView: View {
    @Binding var orders: [Order]
    var currentUserId: String
    @State private var selectedOrder: Order?
    @State private var showingPayment = false
    @State private var showOrderForm = false
    
    var body: some View {
        NavigationView {
            List(orders) { order in
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("接机时间：")
                            .foregroundColor(.gray)
                        Text(order.pickupTime, style: .date)
                    }
                    
                    HStack {
                        Text("接机地点：")
                            .foregroundColor(.gray)
                        Text(order.pickupLocation)
                    }
                    
                    HStack {
                        Text("送达地点：")
                            .foregroundColor(.gray)
                        Text(order.dropoffLocation)
                    }
                    
                    if let flightInfo = order.flightInfo {
                        HStack {
                            Text("航班信息：")
                                .foregroundColor(.gray)
                            Text(flightInfo)
                        }
                    }
                    
                    HStack {
                        Text("订单状态：")
                            .foregroundColor(.gray)
                        Text(order.status.rawValue)
                            .foregroundColor(.blue)
                        
                        Spacer()
                        
                        Text("¥\(String(format: "%.2f", order.totalAmount))")
                            .fontWeight(.bold)
                    }
                    
                    if order.status == .pending {
                        Button(action: {
                            selectedOrder = order
                            showingPayment = true
                        }) {
                            Text("去支付")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding(.top, 8)
                    }
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("我的订单")
            .toolbar {
                Button(action: { showOrderForm = true }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingPayment) {
                if let order = selectedOrder {
                    PaymentView(order: order)
                }
            }
            .sheet(isPresented: $showOrderForm) {
                OrderFormView(orders: $orders, currentUserId: currentUserId)
            }
        }
    }
}

#Preview {
    @State var orders: [Order] = [Order.sampleOrder]
    OrderListView(orders: $orders, currentUserId: "test_user")
}
