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
        let notification = NotificationData(identifier: "com.marcostmorais.notifications.tenSecondsFromNow", title: "Let's Go!", body: "This is a notification")
        
        // Creates a Date
        let date = Date().addingTimeInterval(10)
        
        // Schedules!
        shoutoutCenter.scheduleNotification(notification: notification, date: date, repeats: false)
    }
    
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}
