import SwiftUI

struct LuggageFormView: View {
    @Binding var luggages: [LuggageItem]
    @Environment(\.dismiss) private var dismiss
    @State private var showImagePicker = false
    @State private var imagePickerIndex: Int? = nil

    var body: some View {
        NavigationView {
            List {
                ForEach($luggages) { $item in
                    Section {
                        Picker("行李类型", selection: $item.type) {
                            ForEach(LuggageType.allCases) { type in
                                Text(type.rawValue).tag(type)
                            }
                        }
                        Stepper(value: $item.count, in: 1...10) {
                            Text("数量：\(item.count)")
                        }
                        Toggle("是否托运", isOn: $item.isChecked)
                        HStack {
                            if let image = item.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            Button("上传照片") {
                                imagePickerIndex = luggages.firstIndex(where: { $0.id == item.id })
                                showImagePicker = true
                            }
                        }
                    }
                }
                .onDelete { indexSet in
                    luggages.remove(atOffsets: indexSet)
                }
            }
            .navigationTitle("行李信息")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("添加行李") {
                        luggages.append(LuggageItem(type: .carryOn, count: 1, image: nil, isChecked: false))
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("完成") {
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showImagePicker) {
                if let index = imagePickerIndex {
                    ImagePicker(image: Binding(
                        get: { luggages[index].image },
                        set: { luggages[index].image = $0 }
                    ))
                }
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) private var presentationMode

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
} 
