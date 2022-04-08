//
//  TaskTypeCell.swift
//  ToDoManager
//
//  Created by Евгений Макеев on 04.04.2022.
//

import UIKit

class TaskTypeCell: UITableViewCell {
    
    // for using in controller TaskPriorityUITVC
    @IBOutlet var typeTitleLabel: UILabel!
    @IBOutlet var typeDescriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
