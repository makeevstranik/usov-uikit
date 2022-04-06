//
//  TaskEditUITVC.swift
//  ToDoManager
//
//  Created by Евгений Макеев on 02.04.2022.
//

import UIKit

class TaskEditUITVC: UITableViewController, EditAccessibleProtocol {
    
    var taskEdit: TaskProtocol!
  
    var completionClosure: ((TaskProtocol) -> Void)?
    
    @IBOutlet weak var prioritySwitcher: UISwitch!
    
    @IBOutlet weak var taskPriorityLabel: UILabel!
    
    @IBOutlet weak var taskStatusLabel: UILabel!
    
    @IBOutlet weak var taskTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // updateView()
        print("In viewDidLoad()")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("In viewWillAppear()")
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
        closure(taskEdit)
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
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

}

// MARK: - Segue To Priority Edition
extension TaskEditUITVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "toTaskPriorityUITVC":
                guard let controller = segue.destination as? TaskPriorityUITVC else { return }
                controller.delegateTaskEditUITVC = self
            default: return
        }
    }
}
// MARK: - Get Controller From Stack
//extension TaskEditUITVC {
//    private func getControllerFromStack(titleController: String) -> TransferChangeableProtocol {
//        return navigationController?.viewControllers.first(where: {$0.title == titleA}) as! TransferChangeableProtocol
//    }
//}
