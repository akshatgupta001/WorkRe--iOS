//
//  workplaceTableViewCell.swift
//  WorkRe
//
//  Created by Akshat Gupta on 21/05/20.
//  Copyright © 2020 coded. All rights reserved.
//

import UIKit

class workplaceTableViewCell: UITableViewCell {

    @IBOutlet weak var cafe_name: UILabel!
    @IBOutlet weak var cafe_location: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var rating: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
