//
//  LucasWidGet.swift
//  LucasWidGet
//
//  Created by Lucas Pontes on 31/10/23.
//

import WidgetKit
import SwiftUI

// Esta é a estrutura responsável por fornecer os dados para o widget.
struct Provider: AppIntentTimelineProvider {
    
    // Este método fornece um placeholder (visualização inicial) para o widget.
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    // Este método fornece uma visualização estática para o widget.
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    // Este método gera a linha do tempo do widget com as entradas dinâmicas.
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Gera uma linha do tempo com cinco entradas, uma a cada hora, a partir da data atual.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

// Esta é a estrutura que representa uma entrada na linha do tempo do widget.
struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

// Esta é a visualização do widget.
struct LucasWidGetEntryView : View {
    var body: some View {
            
        HStack{
                    VStack(alignment: .leading){
                        Text("Weight")
                            .font(.body)
                            .foregroundColor(.purple)
                            .bold()
                        Spacer()
                        Text("Lucas")
                            .font(.title)
                            .foregroundColor(.purple)
                            .bold()
                            .minimumScaleFactor(0.7)
                    }
                    Spacer()
                }
                .padding(.all, 8)
                .background(ContainerRelativeShape().fill(Color(.cyan)))
            }
          
    }


// Esta é a estrutura que define o widget em si.
struct LucasWidGet: Widget {
    let kind: String = "LucasWidGet"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            LucasWidGetEntryView()
                .containerBackground(.cyan, for: .widget)
        }
    }
}


// Esta é uma visualização de pré-visualização para o widget.
#Preview(as: .systemSmall) {
    LucasWidGet()
} timeline: {
    SimpleEntry(date: .now, configuration: ConfigurationAppIntent())
   
}
