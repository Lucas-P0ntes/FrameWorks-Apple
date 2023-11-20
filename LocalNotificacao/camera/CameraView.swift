//
//  CameraView.swift
//  LocalNotificacao
//
//  Created by Lucas Pontes on 05/11/23.
//

import SwiftUI

struct CameraView: View {
    @State private var isShowingCameraPicker = false // Estado para controlar a exibição do seletor de câmera
    @State private var isShowingGalleryPicker = false // Estado para controlar a exibição do seletor de galeria
    @State private var selectedImage: UIImage? // Estado para armazenar a imagem selecionada
    var body: some View {
        ZStack{
            Color(.gray).ignoresSafeArea()
            VStack {
                if let image = selectedImage {
                    // Se uma imagem foi selecionada, exibe a imagem
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    
                } else {
                    // Se nenhuma imagem foi selecionada, exibe os botões para abrir a câmera e a galeria
                    HStack {
                        Button("Abrir Câmera 📸") {
                            isShowingCameraPicker.toggle() // Altera o estado para exibir o seletor de câmera
                        }
                        .frame(width: 100, height: 70)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .padding()
                        .sheet(isPresented: $isShowingCameraPicker, content: {
                            CameraPicker(selectedImage: $selectedImage, isShowingImagePicker: $isShowingCameraPicker)
                            // Abre o seletor de câmera quando isShowingCameraPicker é true
                        })
                        
                        
                        
                        Button("Abrir Galeria 🌌") {
                            isShowingGalleryPicker.toggle() // Altera o estado para exibir o seletor de galeria
                        }
                        .frame(width: 100, height: 70)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .padding()
                        .sheet(isPresented: $isShowingGalleryPicker, content: {
                            GalleryPicker(selectedImage: $selectedImage, isShowingGalleryPicker: $isShowingGalleryPicker)
                            // Abre o seletor de galeria quando isShowingGalleryPicker é true
                        })
                        
                        
                    }
                }
            }
        }
    }
}

#Preview {
    CameraView()
}
