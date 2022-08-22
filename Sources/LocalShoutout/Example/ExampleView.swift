//
//  ExampleView.swift
//  
//
//  Created by Marcos Morais on 22/08/22.
//

import SwiftUI

struct ExampleView: View {
    
    let shoutoutCenter: LocalShoutoutCenter = LocalShoutoutCenter()
    
    @State var authenticated: Bool = false
    
    var body: some View {
        VStack {
            Text("Schedule Notifications!")
                .font(.system(.title, design: .rounded))
            Button(action: authenticate) {
                Text("Authenticate!")
            }

            Button(action: scheduleNotification) {
                Text("Schedule!")
            }
            .disabled(!authenticated)
        }
        .onAppear {
            self.authenticated = shoutoutCenter.authenticated
        }
    }
    
    private func authenticate() {
        shoutoutCenter.authenticate()
    }
    
    private func scheduleNotification() {
        let notification = NotificationData(identifier: "com.marcostmorais.notifications.weekFromNow", title: "Let's Go!", body: "This is a notification", notificationType: .oneTime)
        shoutoutCenter.scheduleNotification(notification: notification, date: Date().addingTimeInterval(10), repeats: false)
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}
