//
//  Optional+Extensions.swift
//  
//
//  Created by Marcos Morais on 22/08/22.
//

import Foundation

extension Optional where Wrapped == String {
    public var orEmpty: String {
        switch self {
        case .some(let value):
            return value
            
        case .none:
            return ""
        }
    }
    
    public func orEmpty(fallbackString: String = "") -> String {
        switch self {
        case .some(let value):
            return value
            
        case .none:
            return fallbackString
        }
    }
}
