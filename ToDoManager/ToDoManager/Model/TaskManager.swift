//
//  TaskManager.swift
//  ToDoManager
//
//  Created by Евгений Макеев on 27.03.2022.
//

import Foundation
import UIKit

final class TaskManager {
    
    private var storage: TaskStorage = TaskStorage()
    var transformKeys: [TaskPriority] = TaskPriority.allCases
    var transformedTasks: [TaskPriority : [TaskProtocol]]! {
        didSet {
            saveTasksToStorage()
        }
    }
    
    var getPriorityCount: Int { transformKeys.count }
    
    init() {
        self.transformedTasks = self.transformKeys.reduce(into: [:], { acc, el in
            acc.updateValue([], forKey: el)
        })
        self.loadAndTransformTasks()
    }
    
    func getTask(from source: TaskPosition) -> TaskProtocol? {
        let key = transformKeys[source.key]
        guard let task = self.transformedTasks[key]?[source.pos] else { return nil }
        // if Task is class - create new instance here
        return Task(title: task.title, type: task.type, status: task.status)
    }
    
    func getTasksCountForPriority(for key: Int) -> Int? {
        let key = transformKeys[key]
        return self.transformedTasks[key]?.count
    }
    
    func getPriorityDescription(for index: Int) -> String? {
        guard let priority = TaskPriority(rawValue: index) else { return nil }
        return priority.description
    }
    
    func moveTask(from source: TaskPosition, to destination: TaskPosition) {
        let keyDestination = transformKeys[destination.key]
        guard var movingTask = deleteTask(from: source) else { return }
        movingTask.type = TaskPriority(rawValue: destination.key)!
        // code changing priority in case it has been changed
        self.transformedTasks[keyDestination]?.insert(movingTask, at: destination.pos)
        sortTransformedTasks(for: [keyDestination])
    }
    
    func saveNewTask(_ task: TaskProtocol) -> Bool {
        guard !task.title.isEmpty else { return false }
        guard self.transformedTasks[task.type]?.append(task) != nil else { return false }
        sortTransformedTasks(for: [task.type])
        return true
    }
    
    func deleteTask(from source: TaskPosition) -> TaskProtocol? {
        //print("TaskManager.deleteTask(_ key: Int, _ position: Int) KEY:", source.key)
        let key = transformKeys[source.key]
        return self.transformedTasks[key]?.remove(at: source.pos)
    }
    
    func changeTask(from source: TaskPosition, to editedTask: TaskProtocol) {
        let key = transformKeys[source.key]
        guard var taskToChange = transformedTasks[key]?[source.pos] else { return }

        changeTaskTitle(from: source, editedTask.title)
        changeTaskType(from: source, editedTask.type)

        //changeTaskStatus(from: source, editedTask.status)
        taskToChange.status = editedTask.status
        sortTransformedTasks(for: [key])
    }
    
    func changeTaskStatus(from source: TaskPosition, _ status: TaskStatus) {
        let key = transformKeys[source.key]
        guard var taskSender = transformedTasks[key]?[source.pos] else { return }
        guard taskSender.status != status else { return }
        taskSender.status = status
        
        sortTransformedTasks(for: [key])
    }
    
    func changeTaskType(from source: TaskPosition, _ newType: TaskPriority) {
        let key = transformKeys[source.key]
        guard key != newType else { return  }
        guard var taskSender = self.transformedTasks[key]?[source.pos] else { return }
        
        taskSender.type = newType
        self.transformedTasks[newType]?.append(taskSender)
        self.transformedTasks[key]?.remove(at: source.pos)
    }
    
    func changeTaskTitle(from source: TaskPosition, _ newTitle: String) {
        let key = transformKeys[source.key]
        guard let _ = self.transformedTasks[key]?[source.pos] else { return }
        self.transformedTasks[key]?[source.pos].title = newTitle
    }
    
    // sort only one section(priority) if it doesn't need more
    private func sortTransformedTasks(for priorities: [TaskPriority]) {
        priorities.forEach{ priority in
            self.transformedTasks[priority] = (self.transformedTasks[priority] as! [Task]).sorted(by: <)
        }
    }
    
    func getTypeCount(_ key: TaskPriority) -> Int? {
        transformedTasks[key]?.count
    }
    
    func loadAndTransformTasks() {
        if let rowTasks = storage.loadTasks() {
            rowTasks.forEach({ self.transformedTasks[$0.type]?.append($0) })
            sortTransformedTasks(for: self.transformKeys)
        }
        
    }
    
    func saveTasksToStorage() {
        let rowTasks = self.transformedTasks.flatMap{$1}
        storage.saveTasks(rowTasks)
    }
    
    
    
}
