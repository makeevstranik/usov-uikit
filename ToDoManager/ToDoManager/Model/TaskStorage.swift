//
//  TaskStorage.swift
//  ToDoManager
//
//  Created by Евгений Макеев on 25.03.2022.
//

import Foundation

class TaskStorage: TaskStorageProtocol {
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    let defaults = UserDefaults.standard
    
    func loadTasks() -> [TaskProtocol]? {
        // temporary code - here as example of storage structure
//       return [
//            Task(title: "Buy Bread", type: .current, status: .planned),
//            Task(title: "Wash My Cat", type: .important, status: .planned),
//            Task(title: "Return Back The Debt To Arnold ", type: .important, status: .completed),
//            Task(title: "Buy The New Car ", type: .current, status: .completed)]      ]
        guard let savedTasks = defaults.object(forKey: "savedTasks") as? Data  else { return nil }
        do {
            let loadedTasks = try decoder.decode([Task].self, from: savedTasks)
            return loadedTasks as [TaskProtocol]
        } catch {
            print("Error UserDefaults Loading \(error)")
            return nil
        }
    }
    
    // Task is Codable
    func saveTasks(_ tasks: [TaskProtocol]) {
        do {
            let encoded = try encoder.encode(tasks as? [Task])
            defaults.set(encoded, forKey: "savedTasks")
        } catch {
            print("Error UserDefaults Saving \(error)")
        }
    }
        
}
