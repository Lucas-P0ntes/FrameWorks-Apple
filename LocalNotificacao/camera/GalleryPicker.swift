//
//  GalleryPicker.swift
//  LocalNotificacao
//
//  Created by Lucas Pontes on 05/11/23.
//
import AVFoundation
import SwiftUI
import Foundation


// Define uma View representando o seletor de galeria
struct GalleryPicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage? // Bindings para a imagem selecionada e o estado de exibição do seletor

    @Binding var isShowingGalleryPicker: Bool // Estado para controlar a exibição do seletor

    // Método para criar a view controller do seletor de galeria
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = .photoLibrary // Define a fonte como a galeria de fotos
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Atualiza a view controller (não precisa de implementação neste caso)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: GalleryPicker

        init(parent: GalleryPicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image // Atualiza a imagem selecionada com a imagem da galeria
            }
            parent.isShowingGalleryPicker = false // Fecha o seletor de galeria
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShowingGalleryPicker = false // Fecha o seletor de galeria sem selecionar uma imagem
        }
    }
}



