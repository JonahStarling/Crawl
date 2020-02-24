//
//  CrawlCell.swift
//  Crawl
//
//  Created by Jonah Starling on 2/23/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import UIKit

class CrawlCell: UITableViewCell {

    @IBOutlet weak var crawlName: UILabel!
    @IBOutlet weak var crawlDuration: UILabel!
    @IBOutlet weak var crawlBars: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
