 import Foundation

protocol TaskProtocol {
    var title: String { get set }
    var type: TaskPriority { get set }
    var status: TaskStatus { get set }
}

// storage
protocol TaskStorageProtocol {
    func loadTasks() -> [TaskProtocol]
    func saveTAsk(_ tasks: [TaskProtocol])
}

struct Task: TaskProtocol {
    
    var title: String
    var type: TaskPriority
    var status: TaskStatus
    
}

enum TaskPriority {
    case current
    case important
}

enum TaskStatus {
    case planned
    case completed
}


class TaskStorage: TaskStorageProtocol {
    func loadTasks() -> [TaskProtocol] {
        // temporary code
        return [
            Task(title: "Buy Bread", type: .current, status: .planned),
            Task(title: "Wash My Cat", type: .important, status: .planned),
            Task(title: "Return Back The Debt To Arnold ", type: .important, status: .completed),
            Task(title: "Buy The New Car ", type: .current, status: .completed),
            Task(title: "Present Flowers To My Wife", type: .important, status: .planned),
            Task(title: "Call To Parents", type: .important, status: .planned)
            
        ]
        
    }
    
    func saveTAsk(_ tasks: [TaskProtocol]) {
        // fill later
    }
    
    
}

var taskStorage: TaskStorageProtocol = TaskStorage()

var sectionTypesPosition: [TaskPriority] = [.important, .current]

var tasks: [TaskPriority: [TaskProtocol]] =  sectionTypesPosition.reduce(into: [:], { acc, el in
    acc.updateValue([], forKey: el)
})

func loadTasksTask() -> [TaskPriority: [TaskProtocol]] {
    return taskStorage.loadTasks().reduce(into: tasks, { acc, el in
        acc[el.type]?.append(el)
    })
    }
var arr = loadTasksTask()
print(arr[.important]!)
