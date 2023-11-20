//
//  AppIntent.swift
//  LucasWidGet
//
//  Created by Lucas Pontes on 31/10/23.
//

// Importa os módulos necessários para utilizar o WidgetKit e AppIntents.
import WidgetKit
import AppIntents

// Define uma estrutura chamada ConfigurationAppIntent que adota o protocolo WidgetConfigurationIntent.
struct ConfigurationAppIntent: WidgetConfigurationIntent {
    // Define o título do widget na tela de configuração do iOS.
    static var title: LocalizedStringResource = "Configuration"
    // Define uma descrição para o widget na tela de configuração do iOS.
    static var description = IntentDescription("This is an example widget.")

   
}
