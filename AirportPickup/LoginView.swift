import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @Binding var currentUserId: String
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    
    var body: some View {
        VStack(spacing: 24) {
            Text("登录")
                .font(.largeTitle)
                .bold()
                .padding(.top, 60)
            
            TextField("用户名", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding(.horizontal)
            
            SecureField("密码", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            if let error = errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }
            
            Button("登录") {
                if username == "testuser" && password == "123456" {
                    currentUserId = username
                    isLoggedIn = true
                } else {
                    errorMessage = "用户名或密码错误"
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding(.horizontal)
            
            Spacer()
        }
    }
} 