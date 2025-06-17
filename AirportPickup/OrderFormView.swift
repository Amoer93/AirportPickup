// OrderFormView.swift
import SwiftUI

struct OrderFormView: View {
    @Binding var orders: [Order]
    var currentUserId: String

    @State private var driverId: String = ""
    @State private var selectedTerminal: String = "Melbourne T1"
    let terminals = ["Melbourne T1", "Melbourne T2", "Melbourne T3", "Melbourne T4"]
    @State private var dropoffLocation: String = ""
    @State private var pickupTime: Date = Date()
    @State private var passengerCount: Int = 1
    @State private var luggageCount: Int = 0
    @State private var totalAmount: String = ""
    @State private var isFirstTime: Bool = false
    @State private var showAlert = false
    @State private var showDriverSelection = false
    @State private var selectedDriver: Driver? = nil
    @State private var luggages: [LuggageItem] = []
    @State private var showLuggageForm = false
    @State private var flightInfo: String = ""

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Form {
            Section(header: Text("订单信息")) {
                Text("用户ID：\(currentUserId)")
                Button(selectedDriver == nil ? "选择司机" : "已选：\(selectedDriver!.name)") {
                    showDriverSelection = true
                }
                .sheet(isPresented: $showDriverSelection) {
                    NavigationView {
                        DriverSelectionView(drivers: sampleDrivers, selectedDriver: $selectedDriver)
                    }
                }
                Picker("接机航站楼", selection: $selectedTerminal) {
                    ForEach(terminals, id: \.self) { terminal in
                        Text(terminal)
                    }
                }
                TextField("航班信息", text: $flightInfo)
                TextField("目的地", text: $dropoffLocation)
                DatePicker("接送时间", selection: $pickupTime, displayedComponents: [.date, .hourAndMinute])
                Stepper(value: $passengerCount, in: 1...10) {
                    Text("乘客人数：\(passengerCount)")
                }
                Button("填写行李信息（已添加：\(luggages.count)条）") {
                    showLuggageForm = true
                }
                .sheet(isPresented: $showLuggageForm) {
                    LuggageFormView(luggages: $luggages)
                }
                Toggle("是否首次来澳大利亚", isOn: $isFirstTime)
                TextField("订单金额", text: $totalAmount)
                    .keyboardType(.decimalPad)
            }
            Section {
                Button("提交订单") {
                    let driver = selectedDriver ?? sampleDrivers.randomElement()!
                    let order = Order(
                        userId: currentUserId,
                        driverId: driver.id,
                        pickupLocation: selectedTerminal,
                        dropoffLocation: dropoffLocation,
                        pickupTime: pickupTime,
                        passengerCount: passengerCount,
                        luggageCount: luggages.reduce(0) { $0 + $1.count },
                        totalAmount: Double(totalAmount) ?? 0,
                        flightInfo: flightInfo.isEmpty ? nil : flightInfo
                    )
                    orders.append(order)
                    showAlert = true
                    // 重置表单
                    selectedDriver = nil
                    selectedTerminal = "Melbourne T1"
                    dropoffLocation = ""
                    pickupTime = Date()
                    passengerCount = 1
                    luggages = []
                    totalAmount = ""
                    isFirstTime = false
                    flightInfo = ""
                }
            }
        }
        .navigationTitle("填写订单")
        .alert("提交成功", isPresented: $showAlert) {
            Button("确定") { dismiss() }
        } message: {
            Text("您的订单已提交！")
        }
    }
}
