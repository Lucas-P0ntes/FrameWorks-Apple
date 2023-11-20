
//

//


import SwiftUI
import EventKitUI

// Importando as bibliotecas necessárias: SwiftUI e EventKitUI.

struct EventEditViewController: UIViewControllerRepresentable {
    // Definindo uma estrutura chamada EventEditViewController que conforma ao protocolo UIViewControllerRepresentable.

    @Environment(\.presentationMode) var presentationMode
    // Declaração de uma variável chamada presentationMode que será usada para controlar a apresentação do view controller.

    typealias UIViewControllerType = EKEventEditViewController
    // Especifica que o tipo de view controller que será apresentado é EKEventEditViewController.

    let ticket: Ticket
    // Declaração de uma constante chamada ticket que provavelmente contém informações sobre um evento.

    private let store = EKEventStore()
    // Criação de uma instância de EKEventStore, que será usada para interagir com os eventos no calendário do dispositivo.

    private var event: EKEvent {
        // Define uma propriedade computada chamada event que retorna um objeto EKEvent.

        let event = EKEvent(eventStore: store)
        // Cria uma instância de EKEvent, associada à EKEventStore que foi criada anteriormente.

        event.title = ticket.title
        // Define o título do evento com base no título do ticket.

        if let startDate = ticket.startDate, let endDate = ticket.endDate {
            // Verifica se tanto a data de início quanto a data de término do ticket estão definidas.

            let startDateComponents = DateComponents(year: startDate.year,
                                                     month: startDate.month,
                                                     day: startDate.day,
                                                     hour: startDate.hour,
                                                     minute: startDate.minute)
            // Cria um objeto DateComponents para a data de início do evento.

            event.startDate = Calendar.current.date(from: startDateComponents)!
            // Configura a data de início do evento com base nas componentes da data criadas.

            let endDateComponents = DateComponents(year: endDate.year,
                                                     month: endDate.month,
                                                     day: endDate.day,
                                                     hour: endDate.hour,
                                                     minute: endDate.minute)
            // Cria um objeto DateComponents para a data de término do evento.

            event.endDate = Calendar.current.date(from: endDateComponents)!
            // Configura a data de término do evento com base nas componentes da data criadas.

            event.location = ticket.location
            // Define a localização do evento com base na localização do ticket.

            event.notes = "Don't forget to bring popcorn🍿️!"
            // Adiciona uma nota ao evento.
        }

        return event
        // Retorna o evento configurado.
    }

    func makeUIViewController(context: Context) -> EKEventEditViewController {
        // Implementa o método makeUIViewController, que cria e retorna uma instância de EKEventEditViewController.

        let eventEditViewController = EKEventEditViewController()
        // Cria uma instância de EKEventEditViewController.

        eventEditViewController.event = event
        // Define o evento associado ao view controller criado anteriormente.

        eventEditViewController.eventStore = store
        // Define a EKEventStore associada ao view controller.

        eventEditViewController.editViewDelegate = context.coordinator
        // Define o coordenador como o delegado do view controller.

        return eventEditViewController
        // Retorna o EKEventEditViewController configurado.
    }

    func updateUIViewController(_ uiViewController: EKEventEditViewController, context: Context) {
        // Implementa o método updateUIViewController, que atualiza a view quando ocorrem mudanças no contexto.
    }

    func makeCoordinator() -> Coordinator {
        // Implementa o método makeCoordinator, que cria e retorna uma instância de Coordinator.

        return Coordinator(self)
        // Retorna um novo Coordinator, passando a instância atual de EventEditViewController como parâmetro.
    }

    class Coordinator: NSObject, EKEventEditViewDelegate {
        // Define uma classe chamada Coordinator que herda de NSObject e conforma ao protocolo EKEventEditViewDelegate.

        var parent: EventEditViewController
        // Declara uma variável chamada parent que armazena uma referência ao EventEditViewController associado.

        init(_ controller: EventEditViewController) {
            // Inicializa o Coordinator com uma referência ao EventEditViewController associado.

            self.parent = controller
        }

        func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
            // Implementa o método do protocolo EKEventEditViewDelegate que é chamado quando o usuário interage com a tela de edição de evento.

            parent.presentationMode.wrappedValue.dismiss()
            // Dismissa o view controller quando o usuário completa a ação na tela de edição de evento.
        }
    }
}
