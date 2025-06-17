import SwiftUI

struct DriverSelectionView: View {
    let drivers: [Driver]
    @Binding var selectedDriver: Driver?
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        List(drivers) { driver in
            VStack(alignment: .leading, spacing: 8) {
                HStack {
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
                    VStack(alignment: .leading) {
                        Text(driver.name)
                            .font(.headline)
                        Text("国籍：\(driver.nationality)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Button("选择") {
                        selectedDriver = driver
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                }
                HStack {
                    Text("接单量：\(driver.orderCount)")
                    Spacer()
                    Text("车型：\(driver.carTypes.joined(separator: ", "))")
                }
                HStack {
                    Text("评分：")
                    ForEach(1...5, id: \.self) { i in
                        Image(systemName: i <= Int(driver.rating.rounded()) ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                    }
                    Text(String(format: "%.1f", driver.rating))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical, 8)
        }
        .navigationTitle("选择司机")
    }
} 