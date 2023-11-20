//
//  LocalNotificacaoApp.swift
//  LocalNotificacao
//
//  Created by Lucas Pontes on 30/10/23.
//

import SwiftUI
import TipKit

@main
struct TecnologiasApple: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                   //Podemos configurar um tempo 
                  //  let threeDays: TimeInterval = 3 * 24 * 60 * 60
                    try?
                    Tips.configure([
                        .displayFrequency(.immediate),
                        .datastoreLocation(.applicationDefault)
                    ])
                }
        }
    }
}

