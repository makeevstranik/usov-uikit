//
//  ViewController.swift
//  Contacts
//
//  Created by Евгений Макеев on 16.03.2022.
//

import UIKit

typealias C = Constants

class ViewController: UIViewController {
    
    @IBOutlet weak var contactTableView: UITableView!
    
    var contacts = [ContactProtocol]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContacts()
        // Do any additional setup after loading the view.
    }
    private func loadContacts() {
        contacts.append(Contact(title: "Elsa Hosk", phone: "+799912312323"))
        contacts.append(Contact(title: "Bella Hadid", phone: "+781213342321"))
        contacts.append(Contact(title: "Gigi Hadid", phone: "+7000911112"))
        contacts.sort(by: { $0.title < $1.title })
    }
    
    @IBAction func addContactPressed(_ sender: UIBarButtonItem) {
        changeContactFromAlert(contactTableView, indexPath: nil)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: C.contactCellIdentifier) {
            cell = reuseCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: C.contactCellIdentifier)
        }
        cell.setMyConfiguration(for: contacts[indexPath.row])
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        print("Determining available actions for the row \(indexPath.row) ")
        let actionChangeRow = UIContextualAction(style: .normal, title: "Change", handler: { _, _, _ in
            self.changeContactFromAlert(tableView, indexPath: indexPath)
        })
        
        let actionDeleteRow = UIContextualAction(style: .destructive, title: "Delete", handler: { _, _, _ in
            self.contacts.remove(at: indexPath.row)
            tableView.reloadData()
        })
        
        let actions = UISwipeActionsConfiguration(actions: [actionChangeRow, actionDeleteRow])
        return actions
    }
    
}

extension UITableViewCell {
    
    func setMyConfiguration(for contact: ContactProtocol) {
        var cellConfiguration = self.defaultContentConfiguration()
        cellConfiguration.text = contact.title
        cellConfiguration.secondaryText = contact.phone
        self.contentConfiguration = cellConfiguration
    }
    
}


extension ViewController {
    
    func changeContactFromAlert(_ tableView: UITableView, indexPath: IndexPath?) {
        
        let alert = UIAlertController(title: "Change Contact", message: "Fill Contact", preferredStyle: .alert)
        
        alert.addTextField{ $0.placeholder = "Enter The Name" }
        alert.addTextField{ $0.placeholder = "Enter The Phone" }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] _ in
            guard let title = alert?.textFields![0].text else { return }
            guard let phone = alert?.textFields![1].text else { return }
            guard !title.isEmpty && !phone.isEmpty else { return }
            let newContact = Contact(title: title, phone: phone)
            if let indexPath = indexPath {
            self.contacts[indexPath.row] = newContact
            } else {
                self.contacts.append(newContact)
            }
            tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            tableView.reloadData()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}


