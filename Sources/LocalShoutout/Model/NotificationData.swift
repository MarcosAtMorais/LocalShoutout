//
//  File.swift
//  
//
//  Created by Marcos Morais on 22/08/22.
//

import Foundation
import UserNotifications

/**
 The Notification model. It consists of a Title, Body, Sound and Identifier that are going to be converted into UNNotificationContent.
 */
public struct NotificationData: Identifiable {
    
    /// The identifier that is going to be used on the UserNotifications framework. It *must* be unique.
    public var identifier: String?
    /// The title of your Notification.
    public var title: String
    /// The body of your Notification.
    public var body: String
    /// The string that references a sound inside your bundle (it *must* not be longer than 30 seconds)
    public var sound: String?
    
    /// Computed property that determines if it has anything for the sound.
    public var hasSound: Bool {
        sound != nil
    }
    
    /// Identifiable conformance
    public var id: String {
        return identifier == nil ? (title + body).replacingOccurrences(of: " ", with: "") : identifier.orEmpty
    }
    
    // MARK: - Initializers
    public init(identifier: String? = nil, title: String = "Title of the Notification", body: String = "This is the body of the notification.") {
        self.identifier = identifier
        self.title = title
        self.body = body
    }
    
    public init(identifier: String? = nil, title: String = "Title of the Notification", body: String = "This is the body of the notification.", sound: String? = nil) {
        self.identifier = identifier
        self.title = title
        self.body = body
        self.sound = sound
    }

}
