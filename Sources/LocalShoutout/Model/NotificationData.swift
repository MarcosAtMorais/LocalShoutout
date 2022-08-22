//
//  File.swift
//  
//
//  Created by Marcos Morais on 22/08/22.
//

import Foundation
import UserNotifications

public struct NotificationData: Identifiable {
    
    public var identifier: String?
    public var title: String
    public var body: String
    public var sound: String?
    public var type: NotificationType
    
    public var hasSound: Bool {
        sound != nil
    }
    
    public var id: String {
        return identifier == nil ? (title + body).replacingOccurrences(of: " ", with: "") : identifier.orEmpty
    }
    
    init(identifier: String? = nil, title: String = "Title", body: String = "This is the body of the notification.", sound: String? = nil, notificationType: NotificationType = .oneTime) {
        self.title = title
        self.body = body
        self.sound = sound
        self.type = notificationType
    }

}
