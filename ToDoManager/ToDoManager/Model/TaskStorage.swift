//
//  TaskStorage.swift
//  ToDoManager
//
//  Created by Евгений Макеев on 25.03.2022.
//

import Foundation

class TaskStorage: TaskStorageProtocol {
    func loadTasks() -> [TaskProtocol] {
        // temporary code
       return [
            Task(title: "Buy Bread", type: .current, status: .planned),
            Task(title: "Wash My Cat", type: .important, status: .planned),
            Task(title: "Return Back The Debt To Arnold ", type: .important, status: .completed),
            Task(title: "Buy The New Car ", type: .current, status: .completed),
            Task(title: "Present Flowers To My Wife", type: .important, status: .planned),
            Task(title: "Call To Parents", type: .important, status: .planned),
            Task(title: "Read That Interesting Book About Sad Answerless Love", type: .current, status: .planned),
            Task(title: "Have A NIce Dream About Being Together With My Family", type: .current, status: .completed)
                
        ]
        
    }
    
    func saveTasks(_ tasks: [TaskProtocol]) {
        // fill later
    }
    
    
}
