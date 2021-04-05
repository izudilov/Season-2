//
//  TableViewCell.swift
//  ToDoList
//
//  Created by user179996 on 05.04.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var tasksName: UILabel!
    @IBOutlet var countOfTasks: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
