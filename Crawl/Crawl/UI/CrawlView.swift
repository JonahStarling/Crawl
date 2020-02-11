//
//  CrawlView.swift
//  Crawl
//
//  Created by Jonah Starling on 2/11/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import UIKit

class CrawlView: UIView {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCrawlView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initCrawlView()
    }
    
    func initCrawlView() {
        Bundle(for: type(of: self)).loadNibNamed("CrawlView", owner: self, options: nil)
        view.frame = self.bounds
        addSubview(view)
    }
}
