//
//  TaskPriorityUITVC.swift
//  ToDoManager
//
//  Created by Евгений Макеев on 04.04.2022.
//

import UIKit

class TaskPriorityUITVC: UITableViewController {
    
    var task: TaskProtocol!
    var taskManager: TaskManager!
    var selectedPriority: TaskPriority!
    
    // this delegate was initialized in previous controller TaskEditUITVC in prepare()
    var delegateTaskEditUITVC: TaskEditUITVC!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        taskManager = TaskManager()
        
        // TAKE DATA FROM PREVIOUS CONTROLLER
        selectedPriority = delegateTaskEditUITVC.taskEdit.type
        
        // registration of xib cell from TaskTypeCell
        let cellNib = UINib(nibName: "TaskTypeCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "TaskTypeCell")
    }
  
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskManager.getPriorityCount
    }

    // make cells from xib template
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTypeCell", for: indexPath) as! TaskTypeCell
        let priority = TaskPriority(rawValue: indexPath.row)
        
        // outlets from TaskTypeCell
        cell.typeTitleLabel.text = priority?.description
        cell.typeDescriptionLabel.text = priority?.instruction
        
        if selectedPriority == priority {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath)
        currentCell?.accessoryType = .checkmark
        
        // SEND DATA TO PREVIOUS CONTROLLER
        delegateTaskEditUITVC.taskEdit.type = TaskPriority(rawValue: indexPath.row)!
        
        // disable .checkmark in all other cells
        tableView.visibleCells.forEach{ cell in
            if cell != currentCell {
                cell.accessoryType = .none
            }
        }
    }
    

}
