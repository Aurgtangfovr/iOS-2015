//
//  ColorTableViewCell.swift
//  NextNewApp
//
//  Created by Пользователь on 16.06.15.
//  Copyright (c) 2015 mpei. All rights reserved.
//

import UIKit


class ColorTableViewCell: UITableViewCell {
    
    var namedColor: NNColor? {
        didSet{
            backgroundColor = namedColor?.color
            colorLabel.text = namedColor?.name
            colorLabel.textColor = namedColor?.invertColor
        }
    }
    
    @IBOutlet weak var colorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
