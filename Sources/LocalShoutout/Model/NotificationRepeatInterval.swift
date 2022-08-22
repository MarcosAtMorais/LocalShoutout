//
//  File.swift
//  
//
//  Created by Marcos Morais on 22/08/22.
//

import Foundation

/**
 An enum containing RepeatIntervals, including the components (Set<Calendar.Component>).
 */
public enum NotificationRepeatInterval: CaseIterable {
    
    case minute
    case hour
    case day
    case week
    case month
    case year
    
    public var components: Set<Calendar.Component> {
        switch self {
        case .minute:
            return [.second]
        case .hour:
            return [.minute]
        case .day:
            return [.hour, .minute]
        case .week:
            return [.weekday, .hour, .minute]
        case .month:
            return [.day, .hour, .minute]
        case .year:
            return [.month, .day, .hour, .minute]
        }
    }
    
}
