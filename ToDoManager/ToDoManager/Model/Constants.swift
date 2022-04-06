//
//  Constants.swift
//  ToDoManager
//
//  Created by Евгений Макеев on 25.03.2022.
//

import Foundation

enum TaskPriority: Int, CaseIterable {
    case current = 0
    case important
   // case canceled
}

extension TaskPriority: CustomStringConvertible {
    var description: String {
        switch self {
            case .current:
                return "current"
            case .important:
                return "important"
//            case .canceled:
//                return "canceled"
        }
    }
    
    var instruction: String {
        switch self {
            case .current:
                return "This task has the casual priority."
            case .important:
                return "This task type has main priority for completing. All important tasks are located above the list."
        }
    }
    

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
    
    var description: String {
        switch self {
            case .planned:
                return "Planned"
            case .completed:
                return "Completed"
        }
    }
    
}
