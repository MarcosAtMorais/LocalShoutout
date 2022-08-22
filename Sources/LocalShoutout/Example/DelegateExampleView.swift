//
//  DelegateExampleView.swift
//  
//
//  Created by Marcos Morais on 22/08/22.
//

import SwiftUI

struct DelegateExampleView: View {
    
    @StateObject var viewModel: DelegateExampleViewViewModel = DelegateExampleViewViewModel()
    
    var body: some View {
        VStack {
            Text("Schedule Notifications!")
                .font(.system(.title, design: .rounded))
            
            HStack {
                Text("Scheduled: \(viewModel.scheduledTimes)")
                Image(systemName: "globe")
                Text("Cancelled: \(viewModel.cancelledTimes)")
            }
            
            Button(action: viewModel.authenticate) {
                Text("Authenticate!")
            }

            Button(action: viewModel.scheduleNotification) {
                Text("Schedule!")
            }
            .disabled(!viewModel.authenticated)
            
            Button(action: viewModel.cancelNotification) {
                Text("Cancel!")
            }
            .disabled(!viewModel.authenticated)
        }
        .padding()
    }
    
}

struct DelegateExampleView_Previews: PreviewProvider {
    static var previews: some View {
        DelegateExampleView()
    }
}

class DelegateExampleViewViewModel: ObservableObject {
    
    @Published var authenticated: Bool = false
    @Published var scheduledTimes: Int = 0
    @Published var cancelledTimes: Int = 0
    
    let shoutoutCenter: LocalShoutoutCenter = LocalShoutoutCenter()
    
    public init() {
        shoutoutCenter.delegate = self
    }
    
    public func authenticate() {
        shoutoutCenter.authenticate()
    }
    
    public func scheduleNotification() {
        // Creates the Notification Data
        let notification = NotificationData(identifier: "com.marcostmorais.notifications.tenSecondsFromNow", title: "Let's Go!", body: "This is a notification")
        
        // Creates a Date
        let date = Date().addingTimeInterval(10)
        
        // Schedules!
        shoutoutCenter.scheduleNotification(notification: notification, date: date, repeats: false)
    }
    
    public func cancelNotification() {
        shoutoutCenter.cancelNotification(identifier: "com.marcostmorais.notifications.tenSecondsFromNow")
    }
    
}

extension DelegateExampleViewViewModel: ShoutableDelegate {
    
    func centerDidStart(center: LocalShoutoutCenter) {
        center.authenticated = self.authenticated
    }

    func didAuthenticate(result: Result<Bool, Error>) {
        switch result {
        case .success(let granted):
            self.authenticated = granted
            
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    func didScheduleNotification(result: Result<NotificationData, Error>) {
        self.scheduledTimes += 1
    }
    
    func didCancelNotification(center: LocalShoutoutCenter) {
        self.cancelledTimes += 1
    }
    
}
