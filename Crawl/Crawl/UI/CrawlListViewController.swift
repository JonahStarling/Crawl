//
//  CrawlListViewController.swift
//  Crawl
//
//  Created by Jonah Starling on 2/23/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import Foundation
import UIKit

class CrawlListViewController: StandardBottomSheetViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var crawlList: UITableView!
    
    private let crawls = Array(Crawls.allCrawls.values)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        crawlList.delegate = self
        crawlList.dataSource = self
        crawlList.register(UINib(nibName: "CrawlCell", bundle: nil), forCellReuseIdentifier: "CrawlCell")
        
        topBar.layer.cornerRadius = 2.5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func closeSheet(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "closeSheet"), object: nil)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = self.crawls[indexPath.row].id
        let userInfo: [String: String] = ["crawlId": id]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "crawlTapped"), object: nil, userInfo: userInfo)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Crawls.allCrawls.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.crawlList.dequeueReusableCell(withIdentifier: "CrawlCell") as! CrawlCell
        let crawl = self.crawls[indexPath.row]
        cell.crawlName.text = crawl.data.name
        cell.crawlDuration.text = "Duration: \(crawl.data.timeframe)"
        let bars = CrawlRepository.getAllBarsForCrawlId(id: crawl.id)
        cell.crawlBars.text = "Bars: \(getConcatenatedBarNames(bars: bars))"
        return cell
    }
    
    func getConcatenatedBarNames(bars: Array<Bar>) -> String {
        var barNames = Array<String>()
        for bar in bars {
            barNames.append(bar.data.name)
        }
        return barNames.joined(separator: ", ")
    }
}
