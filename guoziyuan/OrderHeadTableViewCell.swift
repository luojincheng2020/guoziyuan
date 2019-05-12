//
//  OrderHeadTableViewCell.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/9/1.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit

class OrderHeadTableViewCell: UITableViewCell {
    @IBOutlet weak var detailSubLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberLabelLine: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var markLabel: UILabel!
    @IBOutlet weak var abpriceLabel: UILabel!
    @IBOutlet weak var markLabelLine: UILabel!
    @IBOutlet weak var smailImage: UIImageView!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var bigImage: UIImageView!
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
