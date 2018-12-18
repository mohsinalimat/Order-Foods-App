//
//  CategoriesTableViewCell.swift
//  Order Foods App
//
//  Created by Gerasim Israyelyan on 12/1/18.
//  Copyright © 2018 Gerasim Israyelyan. All rights reserved.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryCellView: UIView!
    @IBOutlet weak var categoryCellImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryView2: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
