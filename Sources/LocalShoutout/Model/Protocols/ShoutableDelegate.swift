//
//  File.swift
//  
//
//  Created by Marcos Morais on 22/08/22.
//

import Foundation

/**
 The delegate that LocalShoutoutCenter has. It is completely optional but may be handy. All events are registered.
 */
public protocol ShoutableDelegate: AnyObject {
    
    /**
     This method is called when the LocalShoutoutCenter is started.
     
      - parameters:
         - center: The reference to the LocalShoutoutCenter.
     */
    func centerDidStart(center: LocalShoutoutCenter)
    
    /**
     This method is called when the LocalShoutoutCenter is deallocated.
     
      - parameters:
         - center: The reference to the LocalShoutoutCenter.
     */
    func centerDidEnd(center: LocalShoutoutCenter)
    
    /**
     When the LocalShoutoutCenter finishes receiving an answer to the Local Notification authorization, it returns with a Result<Bool, Error>.
     
      - parameters:
         - result: The result consists of the granted attribute (bool) from the UserNotifications authorization status.
     */
    func didAuthenticate(result: Result<Bool, Error>)
    
    /**
     This method is called when the LocalShoutoutCenter is preparing to schedule a notification. It is called before every code that handles the scheduling.
     
      - parameters:
         - center: The reference to the LocalShoutoutCenter.
         - notification: The NotificationData that is going to be transformed into a scheduled Notification.
     */
    func willScheduleNotification(center: LocalShoutoutCenter, notification: NotificationData)
    
    /**
     When the LocalShoutoutCenter finishes scheduling a notification to the UserNotifications framework, it returns with a Result<NotificationData, Error>.
     
      - parameters:
         - result: The result consists of the scheduled notification or an Error.
     */
    func didScheduleNotification(result: Result<NotificationData, Error>)
    
    /**
     This method is called when the LocalShoutoutCenter is preparing to cancel a notification. It is called before every code that handles the cancelling.
     
      - parameters:
         - center: The reference to the LocalShoutoutCenter.
     */
    func willCancelNotification(center: LocalShoutoutCenter)
    /**
     When the LocalShoutoutCenter finishes canceling a notification to the UserNotifications framework, it returns the center.
     
      - parameters:
         - center: The reference to the LocalShoutoutCenter.
     */
    func didCancelNotification(center: LocalShoutoutCenter)
    
}

extension ShoutableDelegate {
    
    func centerDidStart(center: LocalShoutoutCenter) { }
    func centerDidEnd(center: LocalShoutoutCenter) { }
    
    func didAuthenticate(result: Result<Bool, Error>) { }
    
    func willScheduleNotification(center: LocalShoutoutCenter, notification: NotificationData) { }
    func didScheduleNotification(result: Result<NotificationData, Error>) { }
    
    func willCancelNotification(center: LocalShoutoutCenter) { }
    func didCancelNotification(center: LocalShoutoutCenter) { }
    
}
