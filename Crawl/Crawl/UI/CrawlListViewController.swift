//
//  CrawlListViewController.swift
//  Crawl
//
//  Created by Jonah Starling on 2/23/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import Foundation
import UIKit

class CrawlListViewController: StandardBottomSheetViewController {
    
    @IBOutlet weak var topBar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topBar.layer.cornerRadius = 2.5
        loadCrawlList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func loadCrawlList() {
        // TODO
    }
    
    @IBAction func navigateToCrawl(_ sender: Any) {
        let userInfo: [String: String] = ["crawlId": "aDBzVYDpMjBo9ykhN35C"]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "crawlTapped"), object: nil, userInfo: userInfo)
    }
    
    @IBAction func closeSheet(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "closeSheet"), object: nil)
    }
}
