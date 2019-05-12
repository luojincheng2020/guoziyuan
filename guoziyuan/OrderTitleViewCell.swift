//
//  OrderHeadTableViewCell.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/9/1.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit

class OrderTitleViewCell: UITableViewCell {
    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
   
    @IBOutlet weak var labelLine: UILabel!
    @IBOutlet weak var height: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        labelLine.backgroundColor = lightColor
        height.constant = LINEHEIGHT
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
