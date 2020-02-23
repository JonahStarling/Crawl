//
//  CrawlViewController.swift
//  Crawl
//
//  Created by Jonah Starling on 2/11/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import UIKit

class CrawlViewController: BottomSheetViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCrawl()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func loadCrawl() {
        // TODO
    }
}
