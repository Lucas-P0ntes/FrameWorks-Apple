//
//  CameraPicker.swift
//  LocalNotificacao
//
//  Created by Lucas Pontes on 05/11/23.
//

import AVFoundation
import SwiftUI
import Foundation

struct CameraPicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage? // Bindings para a imagem selecionada e o estado de exibição do seletor

    @Binding var isShowingImagePicker: Bool // Estado para controlar a exibição do seletor

    // Método para criar a view controller do seletor de câmera
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = .camera // Define a fonte como a câmera
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Atualiza a view controller (não precisa de implementação neste caso)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: CameraPicker

        init(parent: CameraPicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image // Atualiza a imagem selecionada com a imagem capturada pela câmera
            }
            parent.isShowingImagePicker = false // Fecha o seletor de câmera
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShowingImagePicker = false // Fecha o seletor de câmera sem selecionar uma imagem
        }
    }
}
