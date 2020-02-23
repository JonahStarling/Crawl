//
//  BarViewController.swift
//  Crawl
//
//  Created by Jonah Starling on 2/10/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import UIKit

class BarViewController: StandardBottomSheetViewController {
    
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
        
        topBar.layer.cornerRadius = 2.5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func loadBar() {
        barName.text = bar?.data.name
        barInfo.text = bar?.data.info
    }
    
    @IBAction func testNavigation(_ sender: Any) {
        let crawlInfo : [String: String] = ["crawlId": "aDBzVYDpMjBo9ykhN35C"]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "crawlTapped"), object: nil, userInfo: crawlInfo)
    }
    
    @IBAction func closeSheet(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "closeSheet"), object: nil)
    }
}
