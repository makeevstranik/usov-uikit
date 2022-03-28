//
//  Constants.swift
//  ToDoManager
//
//  Created by Евгений Макеев on 25.03.2022.
//

import Foundation

enum TaskPriority: String {
    case current
    case important
}

enum TaskStatus: String {
    
    case planned = "\u{25CB}"
    case completed = "\u{25C9}"
    
    var compareStatus: Int {
        switch self {
            case .planned:
                return 0
            case .completed:
                return 1
        }
    }
    
}
