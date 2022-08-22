//
//  File.swift
//  
//
//  Created by Marcos Morais on 22/08/22.
//

import UserNotifications

extension LocalShoutoutCenter: Shoutable {
    public func authenticate() {
        self.currentNotificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, error in
            if let error = error {
                self?.logger.error("\(error.localizedDescription)")
                self?.delegate?.didAuthenticate(result: .failure(error))
            } else {
                self?.delegate?.didAuthenticate(result: .success(granted))
            }
            self?.authenticated = granted
        }
    }

    public func scheduleNotification(notification: NotificationData, date: Date, repeats: Bool = false) {
        
        if !self.authenticated { self.authenticate() }
        
        self.delegate?.willScheduleNotification(center: self, notification: notification)
        let content = self.buildNotificationContentByUsing(notification)
        let identifier = notification.id
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger: UNCalendarNotificationTrigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: repeats)

        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        currentNotificationCenter.add(request, withCompletionHandler: { [weak self] (error) in
            if let error = error {
                self?.logger.error("\(error.localizedDescription)")
                self?.delegate?.didScheduleNotification(result: .failure(error))
            } else {
                self?.logger.debug("Success and Scheduled to: \(triggerDate)")
                self?.delegate?.didScheduleNotification(result: .success(notification))
            }
        })
    }
    
    public func scheduleNotification(notification: NotificationData, dateComponents: DateComponents, repeats: Bool) {
        
        if !self.authenticated { self.authenticate() }
        
        self.delegate?.willScheduleNotification(center: self, notification: notification)
        let content = self.buildNotificationContentByUsing(notification)
        let identifier = notification.id

        let trigger: UNCalendarNotificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: repeats)

        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        currentNotificationCenter.add(request, withCompletionHandler: { [weak self] (error) in
            if let error = error {
                self?.logger.error("\(error.localizedDescription)")
                self?.delegate?.didScheduleNotification(result: .failure(error))
            } else {
                self?.logger.debug("Success and Scheduled to: \(dateComponents)")
                self?.delegate?.didScheduleNotification(result: .success(notification))
            }
        })
    }
    
    public func cancelAllNotifications() {
        self.delegate?.willCancelNotification(center: self)
        self.currentNotificationCenter.removeAllPendingNotificationRequests()
        self.delegate?.didCancelNotification(center: self)
    }
    
    public func cancelNotification(identifier: String) {
        self.delegate?.willCancelNotification(center: self)
        self.currentNotificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        self.delegate?.didCancelNotification(center: self)
    }
    
    public func cancelNotifications(identifiers: [String]) {
        self.delegate?.willCancelNotification(center: self)
        self.currentNotificationCenter.removePendingNotificationRequests(withIdentifiers: identifiers)
        self.delegate?.didCancelNotification(center: self)
    }
    
}
