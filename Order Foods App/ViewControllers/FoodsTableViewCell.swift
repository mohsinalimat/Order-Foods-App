//
//  FoodsTableViewCell.swift
//  Order Foods App
//
//  Created by Gerasim Israyelyan on 12/1/18.
//  Copyright © 2018 Gerasim Israyelyan. All rights reserved.
//

import UIKit

class FoodsTableViewCell: UITableViewCell {
    @IBOutlet weak var foodsCellView: UIView!
    @IBOutlet weak var foodsCellImage1: UIImageView!
    @IBOutlet weak var foodsCellImage2: UIImageView!
    @IBOutlet weak var foodsCellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
