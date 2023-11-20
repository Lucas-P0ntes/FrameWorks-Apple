//
//  Connectivity.swift
//  LocalNotificacao
//
//  Created by Lucas Pontes on 05/11/23.
//

import Foundation
import MultipeerConnectivity

import SwiftUI

struct ConnectivityView: View {
    
    @State var connectionsLabel: String
    @State var backgroundColor: Color
    let colorService = ColorService()
    
    func change(color : Color) {
        backgroundColor = color
    }
    
    var body: some View {
        ZStack{
            backgroundColor.edgesIgnoringSafeArea(.all)
            VStack{
                Text(self.connectionsLabel)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Spacer()
                HStack{
                    Button(action: {
                        self.colorService.delegate = self
                        self.change(color: .yellow)
                        self.colorService.send(colorName: "yellow")
                    }) {
                        Text("yellow")
                            .foregroundColor(.yellow)
                            .fontWeight(.bold)
                            .frame(width: 60, height: 20)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(Color.black))
                    }
                    Button(action: {
                        self.colorService.delegate = self
                        self.change(color: .red)
                        self.colorService.send(colorName: "red")
                    }) {
                        Text("red")
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                            .frame(width: 60, height: 20)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(Color.black))
                    }
                }
            }
        }.onAppear() {
            self.colorService.delegate = self
            }
    }
}

#Preview {
    ConnectivityView(connectionsLabel: "Connected devices:  ", backgroundColor: .yellow)
}

// Extensão que implementa o protocolo ColorServiceDelegate
extension ConnectivityView : ColorServiceDelegate {
    // Chamado quando a lista de dispositivos conectados muda
    func connectedDevicesChanged(manager: ColorService, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            self.connectionsLabel = "Connected devices: \(connectedDevices)"
        }
    }
    
    // Chamado quando a cor é alterada e compartilhada
    func colorChanged(manager: ColorService, colorString: String) {
        OperationQueue.main.addOperation {
            switch colorString {
            case "red":
                self.change(color: .red)
            case "yellow":
                self.change(color: .yellow)
            default:
                NSLog("%@", "Unknown color value received: \(colorString)")
            }
        }
    }
}
