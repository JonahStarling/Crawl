//
//  DetailedBarCell.swift
//  Crawl
//
//  Created by Jonah Starling on 2/23/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import UIKit

class DetailedBarCell: UITableViewCell {

    @IBOutlet weak var barImage: UIImageView!
    @IBOutlet weak var barName: UILabel!
    @IBOutlet weak var barInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        barImage.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
