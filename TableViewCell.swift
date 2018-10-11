//
//  TableViewCell.swift
//  Timer
//
//  Created by OSU App Center on 10/7/18.
//  Copyright © 2018 OSU App Center. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lapNum: UILabel!
    
    @IBOutlet weak var lapTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
