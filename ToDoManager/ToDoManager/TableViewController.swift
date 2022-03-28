//
//  TableViewController.swift
//  ToDoManager
//
//  Created by Евгений Макеев on 24.03.2022.
//

import UIKit

class TableViewController: UITableViewController {
    
    var taskManager: TaskManager!
    
    var sectionTypesPosition: [TaskPriority]!
    
    var tasks: [TaskPriority: [TaskProtocol]]!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        taskManager = TaskManager()
        tasks = taskManager.getSortedTasksWithPriority()
        sectionTypesPosition = taskManager.taskPriorities
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    // number of sections in table
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tasks.count
    }
    
    // rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // let taskType = sectionTypesPosition[section]
        guard let currentTaskType = tasks[taskType(section)] else { return 0 }
        return currentTaskType.count
    }
    
    // cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1 variant
        //return getConfiguredTaskCell_constraints(for: indexPath)
        return getConfiguredTaskCell_stack(for: indexPath)
    }
    
    // header of cells section
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTypesPosition[section].rawValue
    }

    // change task status to completed by click on row (cell)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tasks[taskType(indexPath.section)]?[indexPath.row].status = .completed
        // cancel selection
        tableView.deselectRow(at: indexPath, animated: true)
        //reload sections for IndexSet
        tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // get cell formed from constraints (1 variant)
    private func getConfiguredTaskCell_constraints(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellConstrains", for: indexPath)
        let taskType = sectionTypesPosition[indexPath.section]
        guard let currentTask = tasks[taskType]?[indexPath.row] else { return cell }
        
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
    
    // get cell formed with stack and class TskCell
    private func getConfiguredTaskCell_stack(for indexPath: IndexPath) -> UITableViewCell {
        // load cell from prototypeCell as TaskCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellStack", for: indexPath) as! TaskCell
        // get data for cell
        let taskType = sectionTypesPosition[indexPath.section]
        guard let currentTask = tasks[taskType]?[indexPath.row] else { return cell }
        print("HERE: --->", currentTask)
        
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
    
    func taskType(_ section: Int) -> TaskPriority { sectionTypesPosition[section] }
}
