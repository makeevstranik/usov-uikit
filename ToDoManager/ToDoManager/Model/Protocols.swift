//
//  Protocols.swift
//  ToDoManager
//
//  Created by Евгений Макеев on 25.03.2022.
//

import Foundation

// main TASK
protocol TaskProtocol {
    var title: String { get set }
    var type: TaskPriority { get set }
    var status: TaskStatus { get set }
}

 
protocol TaskStorageProtocol {
    func loadTasks() -> [TaskProtocol]?
    func saveTasks(_ tasks: [TaskProtocol])
}

protocol EditAccessibleProtocol {
    var taskEdit: TaskProtocol! { get set }
    var completionClosure: ((TaskProtocol) -> Void)? { get set }
}

