//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by Nathaniel Remy on 2017-06-06.
//  Copyright © 2017 Nathaniel Remy. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    //MARK: UI properties
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeTitlelLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
