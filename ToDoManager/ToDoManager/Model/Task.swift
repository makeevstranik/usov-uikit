//
//  Task.swift
//  ToDoManager
//
//  Created by Евгений Макеев on 25.03.2022.
//

import Foundation

struct Task: TaskProtocol {
    
    var title: String
    var type: TaskPriority
    var status: TaskStatus
    
}

extension Task: Comparable {
    static func < (lhs: Task, rhs: Task) -> Bool {
        lhs.status.compareStatus < rhs.status.compareStatus
    }
    
    
}
