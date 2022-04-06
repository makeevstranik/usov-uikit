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
    var transformedTasks: [TaskPriority : [TaskProtocol]]!
    
    var getPriorityCount: Int { transformKeys.count }
    
    init() {
        self.transformedTasks = self.transformKeys.reduce(into: [:], { acc, el in
            acc.updateValue([], forKey: el)
        })
        self.loadAndTransformTasks()
    }
    
    func getTask(from source: TaskPosition) -> TaskProtocol? {
        let key = transformKeys[source.key]
        return self.transformedTasks[key]?[source.pos]
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
        print("-moveTask(from source: TaskPosition, to destination: TaskPosition) movingTask: \(movingTask)")
    }
    
    func saveNewTask(_ task: TaskProtocol) {
        // code here then
    }
    
    func deleteTask(from source: TaskPosition) -> TaskProtocol? {
        //print("TaskManager.deleteTask(_ key: Int, _ position: Int) KEY:", source.key)
        let key = transformKeys[source.key]
        return self.transformedTasks[key]?.remove(at: source.pos)
    }
    
    func changeTask(from source: TaskPosition, to editedTask: TaskProtocol) {
        print("In changeTask(from source: TaskPosition, to editedTask: TaskProtocol)/ source: \(source), editedTask: \(editedTask)")
        changeTaskTitle(from: source, editedTask.title)
        
        changeTaskStatus(from: source, editedTask.status)
        print("In changeTask(from source: TaskPosition, to editedTask: TaskProtocol) AFTER CHANGING \n ****** \n transformedTasks: \(transformedTasks!)")
    }
    
    func changeTaskStatus(from source: TaskPosition, _ status: TaskStatus) {
        let key = transformKeys[source.key]
        guard let taskSender = transformedTasks[key]?[source.pos] else { return }
        guard taskSender.status != status else { return }
        
        self.transformedTasks[key]?[source.pos].status = status
        
        sortTransformedTasks(for: [key])
    }
    
    func changeTaskType(from source: TaskPosition, _ newType: TaskPriority) {
        let key = transformKeys[source.key]
        guard key != newType else { return  }
        guard var taskSender = self.transformedTasks[key]?[source.pos] else { return }
        
        taskSender.type = newType
        print("IN changeTaskType(from source: TaskPosition, _ newType: TaskPriority) taskSender: \(taskSender)")
        self.transformedTasks[newType]?.append(taskSender)
        self.transformedTasks[key]?.remove(at: source.pos)
        
        //sortTransformedTasks(for: [newType])
    }
    
    func changeTaskTitle(from source: TaskPosition, _ newTitle: String) {
        print("In changeTaskTitle(from source: TaskPosition, _ newTitle: String) \n newTitle:\(newTitle) ")
        let key = transformKeys[source.key]
        guard var taskSender = self.transformedTasks[key]?[source.pos] else { return }
        print("============================ taskSender: \(taskSender)")
        //taskSender.title = newTitle
        self.transformedTasks[key]?[source.pos].title = newTitle
        print("++++++++++++++++++++++++++++ taskSender: \(taskSender)")
    }
    
    private func sortTransformedTasks(for priorities: [TaskPriority]) {
        priorities.forEach{ priority in
            self.transformedTasks[priority] = (self.transformedTasks[priority] as! [Task]).sorted(by: <)
        }
    }
    
    func getTypeCount(_ key: TaskPriority) -> Int? {
        transformedTasks[key]?.count
    }
    
    func loadAndTransformTasks() {
        let rowTasks = storage.loadTasks()
        rowTasks.forEach({ self.transformedTasks[$0.type]?.append($0) })
        
        sortTransformedTasks(for: self.transformKeys)
    }
    
    func saveTasksToStorage() {
        // code here then
    }
    
    
    
}
