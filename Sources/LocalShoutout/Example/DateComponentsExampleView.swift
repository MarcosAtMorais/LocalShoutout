//
//  DateComponentsExampleView.swift
//  
//
//  Created by Marcos Morais on 22/08/22.
//

import SwiftUI

struct DateComponentsExampleView: View {
    
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
            Button(action: scheduleNotificationWithRepeatInterval) {
                Text("Schedule with Repeat Interval!")
            }
            .disabled(!authenticated)
        }
        .padding()
        .onAppear {
            self.authenticated = shoutoutCenter.authenticated
        }
    }
    
    private func authenticate() {
        shoutoutCenter.authenticate()
    }
    
    private func scheduleNotification() {
        // Creates the Notification Data
        let notification = NotificationData(identifier: "com.marcostmorais.notifications.test", title: "Let's Go!", body: "This is a notification")
        
        // Creates a dateComponents object
        var dateComponents = DateComponents()
        dateComponents.minute = 10
    
        // Schedule!
        shoutoutCenter.scheduleNotification(notification: notification, dateComponents: dateComponents, repeats: false)
    }
    
    private func scheduleNotificationWithRepeatInterval() {
        // Creates the Notification Data
        let notification = NotificationData(identifier: "com.marcostmorais.notifications.test", title: "Let's Go!", body: "This is a notification")
        
        // Creates a dateComponents object that will represent a repeat at 33 minutes and 2 seconds every hour
        var dateComponents = DateComponents()
        dateComponents.minute = 33
        dateComponents.second = 2
    
        // Schedule!
        shoutoutCenter.scheduleNotification(notification: notification, dateComponents: dateComponents, repeats: true, repeatInterval: .hour)
    }
    
}

struct DateComponentsExampleView_Previews: PreviewProvider {
    static var previews: some View {
        DateComponentsExampleView()
    }
}
