import SwiftUI

struct PaymentView: View {
    let order: Order
    @State private var selectedPaymentMethod: PaymentMethod = .wechat
    @State private var isProcessing = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // 订单金额显示
                VStack(spacing: 8) {
                    Text("支付金额")
                        .font(.headline)
                    Text("¥\(String(format: "%.2f", order.totalAmount))")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.blue)
                }
                .padding(.vertical, 30)
                
                // 支付方式选择
                VStack(alignment: .leading, spacing: 15) {
                    Text("选择支付方式")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ForEach(PaymentMethod.allCases, id: \.self) { method in
                        PaymentMethodRow(
                            method: method,
                            isSelected: selectedPaymentMethod == method,
                            action: { selectedPaymentMethod = method }
                        )
                    }
                }
                
                Spacer()
                
                // 支付按钮
                Button(action: {
                    processPayment()
                }) {
                    if isProcessing {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("确认支付")
                            .fontWeight(.semibold)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
                .disabled(isProcessing)
            }
            .navigationTitle("支付订单")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("取消") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func processPayment() {
        isProcessing = true
        // 模拟支付过程
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isProcessing = false
            // TODO: 处理支付结果
            dismiss()
        }
    }
}

struct PaymentMethodRow: View {
    let method: PaymentMethod
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: paymentMethodIcon)
                    .font(.title2)
                    .foregroundColor(.blue)
                    .frame(width: 30)
                
                Text(method.rawValue)
                    .foregroundColor(.primary)
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? Color.blue : Color.gray.opacity(0.3), lineWidth: 1)
            )
        }
        .padding(.horizontal)
    }
    
    private var paymentMethodIcon: String {
        switch method {
        case .wechat:
            return "message.fill"
        case .alipay:
            return "creditcard.fill"
        case .creditCard:
            return "creditcard.circle.fill"
        }
    }
}

#Preview {
    PaymentView(order: Order.sampleOrder)
} 