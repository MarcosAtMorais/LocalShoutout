//
//  File.swift
//  
//
//  Created by Marcos Morais on 22/08/22.
//

import Foundation

extension NotificationData {
    public enum NotificationType: String, CaseIterable, RawRepresentable {
        
        case oneTime = "OneTime"
        case recurring = "Recurring"
        
        var localized: String {
            switch self {
            case .oneTime:
                if #available(macOS 12, iOS 15, watchOS 8, tvOS 15, *) {
                    return String(localized: "One Time")
                } else {
                    return NSLocalizedString("One Time", comment: "The NotificationType localized string for One Time.")
                }
            case .recurring:
                if #available(macOS 12, iOS 15, watchOS 8, tvOS 15, *) {
                    return String(localized: "Recurring")
                } else {
                    return NSLocalizedString("Recurring", comment: "The NotificationType localized string for Recurring.")
                }
            }
        }
        
    }
}
