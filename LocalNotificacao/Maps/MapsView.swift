//
//  MapsView.swift
//  LocalNotificacao
//
//  Created by Lucas Pontes on 05/11/23.
//

import SwiftUI

struct MapsView: View {
    @State private var isShowingMaps = false
    @State private var isShowingMap = false
    var body: some View {
        VStack{
            
            Button("Abrir MapKit") {
                isShowingMaps.toggle()
            }
            .sheet(isPresented: $isShowingMaps, content: {
                Maps()
            })
            
            Button("Abrir CoreLocation ") {
                isShowingMap.toggle()
            }
            .sheet(isPresented: $isShowingMap, content: {
                MapView()
            })
            
        }
    }
}

#Preview {
    MapsView()
}
