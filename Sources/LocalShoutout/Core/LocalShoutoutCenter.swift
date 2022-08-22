//
//  LocalShoutout.swift
//  
//
//  Created by Marcos Morais on 22/08/22.
//

import Foundation
import UserNotifications
import OSLog

open class LocalShoutoutCenter {

    internal let currentNotificationCenter = UNUserNotificationCenter.current()
    internal let logger = Logger(subsystem: "LocalShoutout", category: "LocalNotifications")
    
    public var authenticated: Bool = false
    public weak var delegate: ShoutableDelegate?
    
    public init() {
        self.getAuthenticationStatus()
        delegate?.centerDidStart(center: self)
    }
    
}

extension LocalShoutoutCenter {
    internal func getAuthenticationStatus() {
        self.currentNotificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                self.authenticated = true
            default:
                self.authenticated = false
            }
        }
    }
    
    internal func fetchSoundUsing(_ notification: NotificationData) -> UNNotificationSound {
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
    
    internal func buildNotificationContentByUsing(_ notification: NotificationData) -> UNNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = notification.title
        content.body = notification.body
        content.sound = self.fetchSoundUsing(notification)
        return content
    }
}
