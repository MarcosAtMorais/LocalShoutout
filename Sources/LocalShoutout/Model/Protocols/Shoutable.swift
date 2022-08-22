//
//  Shoutable.swift
//  
//
//  Created by Marcos Morais on 22/08/22.
//

import Foundation
import UserNotifications

/**
 The protocol that serves as the main foundation for LocalShoutoutCenter.
 */
public protocol Shoutable {
    
    /// This variable consists of a bool representing if the UserNotifications framework was granted permission to schedule notifications
    var authenticated: Bool { get set }
    
    /**
     Serves as the main access to authenticate UserNotifications.
     */
    func authenticate()
    
    /**
     This method schedules a notification using a NotificationData, Date and if it repeats (bool).
     
      - parameters:
         - notification: A notification (NotificationData) that builds the notification with everything that UNNotificationContent requires.
         - date: The date in which the notification is going to be triggered.
         - repeats: A boolean that indicates if the notification should be repeated.
     */
    func scheduleNotification(notification: NotificationData, date: Date, repeats: Bool)
    
    /**
     This method schedules a notification using a NotificationData, Date and if it repeats (bool).
     
      - parameters:
         - notification: A notification (NotificationData) that builds the notification with everything that UNNotificationContent requires.
         - dateComponents: The dateComponents that serve as the trigger date.
         - repeats: A boolean that indicates if the notification should be repeated.
     */
    func scheduleNotification(notification: NotificationData, dateComponents: DateComponents, repeats: Bool)
    
    /**
     This method cancels all notifications scheduled.
     */
    func cancelAllNotifications()
    
    /**
     This method cancels notifications using an array of identifiers.
     
      - parameters:
         - identifiers: An array of strings (identifiers) that will be cancelled.
     */
    func cancelNotifications(identifiers: [String])
    
    /**
     This method cancels a single notification using its identifier.
     
      - parameters:
         - identifier: The string of the notification that is going to be cancelled.
     */
    func cancelNotification(identifier: String)
}
