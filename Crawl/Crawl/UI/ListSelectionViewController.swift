//
//  ListSelectionViewController.swift
//  Crawl
//
//  Created by Jonah Starling on 2/23/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import Foundation
import UIKit

class ListSelectionViewController: SmallBottomSheetViewController {
    
    
    @IBOutlet weak var showBarList: UIButton!
    @IBOutlet weak var showCrawlList: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showBarList.layer.cornerRadius = 10.0
        showCrawlList.layer.cornerRadius = 10.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func showBarList(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "barListTapped"), object: nil)
    }
    
    @IBAction func showCrawlList(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "crawlListTapped"), object: nil)
    }
}
