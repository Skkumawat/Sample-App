//
//  CustomFooterCell.swift
//  SampleApp
//
//  Created by Sharvan  Kumawat on 9/30/18.
//  Copyright © 2018 Sharvan  Kumawat. All rights reserved.
//

import UIKit

class CustomFooterCell: UITableViewCell {

    @IBOutlet weak var lblProductType: UILabel!
    @IBOutlet weak var btnViewAll: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
