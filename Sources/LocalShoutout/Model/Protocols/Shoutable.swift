//
//  File.swift
//  
//
//  Created by Marcos Morais on 22/08/22.
//

import Foundation
import UserNotifications

public protocol Shoutable {
    
    var authenticated: Bool { get set }
    
    func authenticate()
    func scheduleNotification(notification: NotificationData, date: Date, repeats: Bool)
    func scheduleNotification(notification: NotificationData, dateComponents: DateComponents, repeats: Bool)
    
    func cancelAllNotifications()
    func cancelNotifications(identifiers: [String])
    func cancelNotification(identifier: String)
}

public protocol ShoutableDelegate: AnyObject {
    
    func centerDidStart(center: LocalShoutoutCenter)
    func centerDidEnd(center: LocalShoutoutCenter)
    
    func didAuthenticate(result: Result<Bool, Error>)
    
    func willScheduleNotification(center: LocalShoutoutCenter, notification: NotificationData)
    func didScheduleNotification(result: Result<NotificationData, Error>)
    
    func willCancelNotification(center: LocalShoutoutCenter)
    func didCancelNotification(center: LocalShoutoutCenter)
    
}
