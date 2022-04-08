//
//  TaskEditUITVC.swift
//  ToDoManager
//
//  Created by Евгений Макеев on 02.04.2022.
//

import UIKit

class TaskEditUITVC: UITableViewController, EditAccessibleProtocol {
    
    // var for exchanging data with TaskPriorityUITVC(with delegate) and TableViewController(with closure)
    var taskEdit: TaskProtocol!
  
    var completionClosure: ((TaskProtocol) -> Void)?
    
    @IBOutlet weak var prioritySwitcher: UISwitch!
    
    @IBOutlet weak var taskPriorityLabel: UILabel!
    
    @IBOutlet weak var taskStatusLabel: UILabel!
    
    @IBOutlet weak var taskTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    @IBAction func saveBarPressed(_ sender: UIBarButtonItem) {
        guard let closure = completionClosure else { return }
        taskEdit.title = taskTextView.text
        
        // MAIN ACTION - SEND DATA TO TableViewController
        closure(taskEdit)
        
        // back to TableViewController
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func statusSwitcherChanged(_ sender: UISwitch) {
        taskEdit.status = sender.isOn ? .planned : .completed
        taskStatusLabel.text = taskEdit.status.description
    }
    
    
    
    func updateView() {
        taskPriorityLabel.text = taskEdit.type.description
        taskTextView.text = taskEdit.title
        taskStatusLabel.text = taskEdit.status.description
        switch taskEdit.status {
            case .planned: prioritySwitcher.isOn = true
            case .completed: prioritySwitcher.isOn = false
        }
        
    }

}

// MARK: - Segue To Priority Edition
extension TaskEditUITVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // save new typed task before leaving (task.title is empty in case of Add Task segue)
        self.taskEdit.title = taskTextView.text
        
        switch segue.identifier {
            case "toTaskPriorityUITVC":
                guard let controller = segue.destination as? TaskPriorityUITVC else { return }
                // set delegate in next controller 
                controller.delegateTaskEditUITVC = self
            default: return
        }
    }
}
