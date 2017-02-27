//
//  HeaderTableViewCell.swift
//  MobiUwb
//
//  Created by Grzegorz Szymański on 27.08.2015.
//  Copyright (c) 2015 Grzegorz Szymański. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var headerTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
