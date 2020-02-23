//
//  BarViewController.swift
//  Crawl
//
//  Created by Jonah Starling on 2/10/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import UIKit

class BarViewController: BottomSheetViewController {
    
    @IBOutlet weak var barName: UILabel!
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var barInfo: UILabel!
    
    @IBOutlet weak var barTL: UIImageView!
    @IBOutlet weak var barTR: UIImageView!
    @IBOutlet weak var barBL: UIImageView!
    @IBOutlet weak var barBR: UIImageView!
    
    var bar: Bar? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func loadBar() {
        topBar.layer.cornerRadius = 2.5
        
        barName.text = bar?.data.name
        barInfo.text = bar?.data.info
    }
    
    @IBAction func testNavigation(_ sender: Any) {
        let crawlInfo : [String: String] = ["crawlId": "a1"]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "crawlTapped"), object: nil, userInfo: crawlInfo)
    }
}
