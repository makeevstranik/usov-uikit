//
//  TaskCell.swift
//  ToDoManager
//
//  Created by Евгений Макеев on 25.03.2022.
//

import UIKit

// class for 2 variant 
class TaskCell: UITableViewCell {

    @IBOutlet var symbolLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    // only for cells that where built in Interface Builder
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
