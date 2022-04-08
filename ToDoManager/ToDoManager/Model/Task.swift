//
//  Task.swift
//  ToDoManager
//
//  Created by Евгений Макеев on 25.03.2022.
//

import Foundation

class Task: TaskProtocol, Codable {
    
    var title: String
    var type: TaskPriority
    var status: TaskStatus
    
    init(title: String, type: TaskPriority, status: TaskStatus) {
        self.title = title
        self.type = type
        self.status = status
    }
    
}

extension Task: Comparable {
    
    static func < (lhs: Task, rhs: Task) -> Bool {
        lhs.status.compareStatus < rhs.status.compareStatus
    }
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        lhs.status.compareStatus == rhs.status.compareStatus
    }
    
}
