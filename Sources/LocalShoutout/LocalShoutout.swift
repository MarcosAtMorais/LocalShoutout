//
//  LocalShoutout.swift
//  
//
//  Created by Marcos Morais on 22/08/22.
//

import Foundation
import UserNotifications
import OSLog

open class LocalShoutout: Shoutable {

    static let shared = LocalShoutout()
    let center = UNUserNotificationCenter.current()
    let logger = Logger(subsystem: "LocalShoutout", category: "LocalNotifications")
    
    public var authenticated: Bool = false
    
    private init() {
        self.getAuthenticationStatus()
    }
    
    public func authenticate() {
        self.center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                self.logger.error("\(error.localizedDescription)")
            }
            self.authenticated = granted
        }
    }

    public func scheduleNotification(notification: NotificationData, date: Date, repeats: Bool = false) {
        let content = self.buildNotificationContentByUsing(notification)
        let identifier = notification.id
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let trigger: UNCalendarNotificationTrigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: repeats)

        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        center.add(request, withCompletionHandler: { [weak self] (error) in
            if let error = error {
                self?.logger.error("\(error.localizedDescription)")
            } else {
                self?.logger.debug("Success and Scheduled to: \(triggerDate)")
            }
        })
    }
    
    public func scheduleNotification(notification: NotificationData, dateComponents: DateComponents, repeats: Bool) {
        let content = self.buildNotificationContentByUsing(notification)
        let identifier = notification.id

        let trigger: UNCalendarNotificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: repeats)

        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        center.add(request, withCompletionHandler: { [weak self] (error) in
            if let error = error {
                self?.logger.error("\(error.localizedDescription)")
            } else {
                self?.logger.debug("Success and Scheduled to: \(dateComponents)")
            }
        })
    }
    
    public func cancelAllNotifications() {
        self.center.removeAllPendingNotificationRequests()
    }
    
    public func cancelNotification(identifier: String) {
        self.center.removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    
    public func cancelNotifications(identifiers: [String]) {
        self.center.removePendingNotificationRequests(withIdentifiers: identifiers)
    }
    
}

extension LocalShoutout {
    fileprivate func getAuthenticationStatus() {
        self.center.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                self.authenticated = true
            default:
                self.authenticated = false
            }
        }
    }
    
    fileprivate func fetchSoundUsing(_ notification: NotificationData) -> UNNotificationSound {
        if notification.hasSound {
            #if os(watchOS)
            // watchOS is not compatible with custom UNNotificationSound(named)
            #else
            let sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: notification.sound.orEmpty))
            return sound
            #endif
        }
        return UNNotificationSound.default
    }
    
    fileprivate func buildNotificationContentByUsing(_ notification: NotificationData) -> UNNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = notification.title
        content.body = notification.body
        content.sound = self.fetchSoundUsing(notification)
        return content
    }
}
