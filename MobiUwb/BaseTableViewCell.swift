//
//  BaseTableViewCell.swift
//  MobiUwb
//
//  Created by Grzegorz Szymański on 19.08.2015.
//  Copyright (c) 2015 Grzegorz Szymański. All rights reserved.
//

import UIKit

public class BaseTableViewCell : UITableViewCell {
    class var identifier: String { return String.className(self) }
 //Only one par needed
    //do prawego menu
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    //do lewego menu
    @IBOutlet weak var leftIconImageView: UIImageView!
    @IBOutlet weak var leftLabel: UILabel!
    
    //do o programie
    @IBOutlet weak var aboutIcon: UIImageView!
    @IBOutlet weak var aboutLabel: UILabel!
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    public func setup() {
    }
    
    override public func setHighlighted(highlighted: Bool, animated: Bool) {
        if highlighted {
            self.alpha = 0.4
        } else {
            self.alpha = 1.0
        }
    }
    
    // ignore the default handling
    override public func setSelected(selected: Bool, animated: Bool) {
    }
    
}