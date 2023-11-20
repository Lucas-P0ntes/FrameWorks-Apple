//
//  NotificationView.swift
//  LocalNotificacao
//
//  Created by Lucas Pontes on 05/11/23.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        
         VStack {
             Button("Request Permission") {
                 UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                     if success {
                         print("All set!")
                     } else if let error = error {
                         print(error.localizedDescription)
                     }
                 }
             }
             Button("Schedule Notification") {
                 let content = UNMutableNotificationContent()
                 content.title = "Título da Notificação"
                 content.subtitle = "Subtítulo da Notificação"
                 content.body = "Corpo da Notificação"
                 let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                 let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                 UNUserNotificationCenter.current().add(request)
             }
         }
         .padding()
    }
}

#Preview {
    NotificationView()
}
