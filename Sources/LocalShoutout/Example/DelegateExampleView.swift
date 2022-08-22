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
        }
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
    
    public init() {
        self.authenticated = LocalShoutoutCenter.shared.authenticated
        LocalShoutoutCenter.shared.delegate = self
    }
    
    public func authenticate() {
        LocalShoutoutCenter.shared.authenticate()
    }
    
    public func scheduleNotification() {
        let notification = NotificationData(identifier: "com.marcostmorais.notifications.weekFromNow", title: "Let's Go!", body: "This is a notification", notificationType: .oneTime)
        LocalShoutoutCenter.shared.scheduleNotification(notification: notification, date: Date().addingTimeInterval(10), repeats: false)
    }
    
}

extension DelegateExampleViewViewModel: ShoutableDelegate {
    
    func centerDidStart(center: LocalShoutoutCenter) {
        
    }
    
    func centerDidEnd(center: LocalShoutoutCenter) {
        
    }
    
    func didAuthenticate(result: Result<Bool, Error>) {
        switch result {
        case .success(let granted):
            self.authenticated = granted
            
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    func willScheduleNotification(center: LocalShoutoutCenter, notification: NotificationData) {
        
    }
    
    func didScheduleNotification(result: Result<NotificationData, Error>) {
        self.scheduledTimes += 1
    }
    
    func willCancelNotification(center: LocalShoutoutCenter) {
        
    }
    
    func didCancelNotification(center: LocalShoutoutCenter) {
        self.cancelledTimes += 1
    }
    
}
