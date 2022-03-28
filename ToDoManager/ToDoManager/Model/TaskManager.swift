//
//  TaskManager.swift
//  ToDoManager
//
//  Created by Евгений Макеев on 27.03.2022.
//

import Foundation

class TaskManager {
    
    var tasksWithPriorities: [TaskPriority: [TaskProtocol]]!
    
    var tasks: [TaskProtocol]!
    
    private var storage: TaskStorage = TaskStorage()
    
    var taskPriorities: [TaskPriority] = [.important, .current]
    
    
    init() {
        self.tasksWithPriorities = taskPriorities.reduce(into: [:], { acc, el in
            acc.updateValue([], forKey: el)
        })
        self.tasks = loadTasks()
    }
    
    func loadTasks() -> [TaskProtocol] {
        return storage.loadTasks()
    }
    
    func sortTasks(for priorities: [TaskPriority]) {
        
    }
    
    func getSortedTasksWithPriority() -> [TaskPriority: [TaskProtocol]] {
        
        let emptyTasksWithPriorities = taskPriorities.reduce(into: [:], { acc, el in
            acc.updateValue([], forKey: el)
        })
        
        return storage.loadTasks()
            .reduce(into: emptyTasksWithPriorities, { acc, task in
            acc[task.type]?.append(task)
            })
            .mapValues{ taskArray -> [TaskProtocol] in
                (taskArray as! [Task]).sorted(by: <)
            }
    }
    
    func saveTasks(_ tasks: [TaskProtocol]) {
        // do some tasks preparations here before saving in storage
        storage.saveTasks(tasks)
    }
    
}
