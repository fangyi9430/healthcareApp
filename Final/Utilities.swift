//
//  Utilities.swift
//  Final
//
//  Created by 李方一 on 12/7/24.
//

import Foundation

class Utilities{
    static let CategoryTypes = ["head issue", "breath issue", "digest issue", "cardiovascular issue", "Kidney issue"]
    
    static let hours = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9","10","11", "12"]
    
    static let minutes: [String] = (0...59).map { String(format: "%02d", $0) }
}
