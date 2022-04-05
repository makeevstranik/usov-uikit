//
//  TableViewController.swift
//  ToDoManager
//
//  Created by Евгений Макеев on 24.03.2022.
//

import UIKit

class TableViewController: UITableViewController {
    
    var taskManager = TaskManager()
    var delegateTaskEditController: EditAccessibleProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // add edit b. to navigationBar
        navigationItem.leftBarButtonItem = editButtonItem
        navigationController?.isToolbarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        delegateTaskEditController = (storyboard.instantiateViewController(withIdentifier: "editController") as! TaskEditUITVC)
    }
    
    // MARK: - Table configuration section
    // number of sections in table
    override func numberOfSections(in tableView: UITableView) -> Int {
        return taskManager.getPriorityCount
    }
    
    // rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskManager.getTasksCountForPriority(for: section) ?? 0
    }
    
    // cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1 variant
        return getConfiguredTaskCell_stack(for: indexPath)
    }
    
    // header of cells section
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        taskManager.getPriorityDescription(for: section)
    }

    // change task status to completed by click on row (cell)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        taskManager.changeTaskStatus(from: TaskPosition(key: indexPath.section, pos: indexPath.row), .completed)
        // cancel selection
        tableView.deselectRow(at: indexPath, animated: true)
        //reload sections for IndexSet
        tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
    }
    
    // MARK: - Using Swipe - change Task status
    // set task to planed status
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard taskManager.getTask(from: TaskPosition(key: indexPath.section, pos: indexPath.row))?.status == .completed else { return nil}
       
        let actionSetPlanedStatus = UIContextualAction(style: .normal, title: "Set Planed", handler: { _, _, _ in
           // self.taskManager.changeTaskStatus(indexPath.section, indexPath.row, .planned)
            self.taskManager.changeTaskStatus(from: TaskPosition(key: indexPath.section, pos: indexPath.row), .planned)
            self.tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
        })
        return UISwipeActionsConfiguration(actions: [actionSetPlanedStatus])
    }
    
override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    let currentTask = taskManager.getTask(from: TaskPosition(key: indexPath.section, pos: indexPath.row))
    delegateTaskEditController.taskEdit = currentTask
    let actionChangeTask = UIContextualAction(style: .normal, title: "Change Task", handler: {_, _, _ in
        self.delegateTaskEditController.completionClosure = { [unowned self] editedTask in
            self.taskManager.changeTask(from: TaskPosition(key: indexPath.section, pos: indexPath.row), to: editedTask)
            self.tableView.reloadData()
        }
        self.navigationController?.pushViewController(self.delegateTaskEditController as! UIViewController, animated: true)
    })
    
    let actionDeleteTask = UIContextualAction(style: .destructive, title: "Delete Task", handler: {_, _, _ in
        if let _ = self.taskManager.deleteTask(from: TaskPosition(key: indexPath.section, pos: indexPath.row)) {
            self.tableView.reloadData()
        }
    })
    return UISwipeActionsConfiguration(actions: [actionChangeTask, actionDeleteTask])
    }
    
   
    
   // MARK: - Row editing section
    // default - true, here just for example
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    // style for edit buttons
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return indexPath.row == 0 ? .insert : .delete
    }
    // what edit methods do
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
            case .delete:
                guard let _ = taskManager.deleteTask(from: TaskPosition(key: indexPath.section, pos: indexPath.row)) else { return }
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
            case .insert: tableView.insertRows(at: [indexPath], with: .automatic)
                // here will code for insertion
            default: return
        }
    }
    // move row by hand
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        taskManager.moveTask(from: TaskPosition(key: sourceIndexPath.section, pos: sourceIndexPath.row),
                             to: TaskPosition(key: destinationIndexPath.section, pos: destinationIndexPath.row))
        tableView.reloadData()
    }
    
    // MARK: - Cell formation section - 2 variants
    // get cell formed from constraints (1 variant)
    private func getConfiguredTaskCell_constraints(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellConstrains", for: indexPath)

        guard let currentTask = taskManager.getTask(from: TaskPosition(key: indexPath.section, pos: indexPath.row)) else { return cell }
        
        let symbolLabel = cell.viewWithTag(1) as? UILabel
        symbolLabel?.text = currentTask.status.rawValue
        
        let textLabel = cell.viewWithTag(2) as? UILabel
        textLabel?.text = currentTask.title
        
        if currentTask.status == .planned {
            symbolLabel?.textColor = .black
            textLabel?.textColor = .black
        } else {
            symbolLabel?.textColor = .lightGray
            textLabel?.textColor = .lightGray
        }
        
        return cell
    }
    
    // get cell formed with stack and class TaskCell
    private func getConfiguredTaskCell_stack(for indexPath: IndexPath) -> UITableViewCell {
        // load cell from prototypeCell as TaskCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellStack", for: indexPath) as! TaskCell
        // get data for cell
        guard let currentTask = taskManager.getTask(from: TaskPosition(key: indexPath.section, pos: indexPath.row)) else { return cell }
        
        //print("HERE: --->", currentTask)
        
        // set for outlets from class
        cell.titleLabel.text = currentTask.title
        cell.symbolLabel.text = currentTask.status.rawValue
        
        switch currentTask.status {
            case .planned:
                cell.titleLabel.textColor = .black
                cell.symbolLabel.textColor = .black
            case .completed:
                cell.titleLabel.textColor = .lightGray
                cell.symbolLabel.textColor = .lightGray
        }
        return cell
    }
    
}

