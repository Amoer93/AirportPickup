import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false
    @State private var currentUserId = ""
    @State private var orders: [Order] = [Order.sampleOrder]

    var body: some View {
        if isLoggedIn {
            NavigationStack {
                VStack(spacing: 40) {
                    Text("欢迎使用留学生接送机App")
                        .font(.title2)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)

                    NavigationLink(destination: OrderFormView(orders: $orders, currentUserId: currentUserId)) {
                        Text("填写订单")
                            .font(.title3)
                            .fontWeight(.bold)
                            .frame(width: 160, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    NavigationLink(destination: OrderListView(orders: $orders, currentUserId: currentUserId)) {
                        Text("我的订单")
                            .font(.title3)
                            .fontWeight(.bold)
                            .frame(width: 160, height: 50)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    Button("退出登录") {
                        isLoggedIn = false
                        currentUserId = ""
                    }
                    .foregroundColor(.red)
                    .padding(.top, 40)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(UIColor.systemGroupedBackground))
            }
        } else {
            LoginView(isLoggedIn: $isLoggedIn, currentUserId: $currentUserId)
        }
    }
}

#Preview {
    ContentView()
}