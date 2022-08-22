//
//  LocalShoutout.swift
//  
//
//  Created by Marcos Morais on 22/08/22.
//

import Foundation
import UserNotifications
import OSLog

open class LocalShoutoutCenter: Shoutable {

    static let shared = LocalShoutoutCenter()
    let currentNotificationCenter = UNUserNotificationCenter.current()
    let logger = Logger(subsystem: "LocalShoutout", category: "LocalNotifications")
    
    public var authenticated: Bool = false
    
    weak var delegate: ShoutableDelegate?
    
    private init() {
        self.getAuthenticationStatus()
        delegate?.centerDidStart(center: self)
    }
    
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

extension LocalShoutoutCenter {
    fileprivate func getAuthenticationStatus() {
        self.currentNotificationCenter.getNotificationSettings { settings in
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
