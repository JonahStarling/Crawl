//
//  CrawlViewController.swift
//  Crawl
//
//  Created by Jonah Starling on 2/11/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import UIKit

class CrawlViewController: StandardBottomSheetViewController {
    
    @IBOutlet weak var topBar: UIView!
    
    var crawl: Crawl? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topBar.layer.cornerRadius = 2.5
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
    
    @IBAction func navigateToBar(_ sender: Any) {
        let userInfo: [String: String] = ["barId": "EwfExtSLMh8OmkYoSPJ7"]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "barTapped"), object: nil, userInfo: userInfo)
    }
    
    @IBAction func closeSheet(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "closeSheet"), object: nil)
    }
}
