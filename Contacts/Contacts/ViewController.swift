//
//  ViewController.swift
//  Contacts
//
//  Created by Евгений Макеев on 16.03.2022.
//

import UIKit

typealias C = Constants

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        C.rowsInTable
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: C.contactCellIdentifier) {
            cell = reuseCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: C.contactCellIdentifier)
        }
        cell.setMyConfiguration(at: indexPath)
        return cell
    }
    
}

extension UITableViewCell {
    
    func setMyConfiguration(at indexPath: IndexPath) {
        var cellConfiguration = self.defaultContentConfiguration()
        cellConfiguration.text = "Row \(indexPath.row)"
        self.contentConfiguration = cellConfiguration
    }
    
}

