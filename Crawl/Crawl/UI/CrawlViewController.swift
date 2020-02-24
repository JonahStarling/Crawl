//
//  CrawlViewController.swift
//  Crawl
//
//  Created by Jonah Starling on 2/11/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import UIKit

class CrawlViewController: StandardBottomSheetViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var crawlName: UILabel!
    @IBOutlet weak var crawlDuration: UILabel!
    @IBOutlet weak var barList: UITableView!
    
    var crawl: Crawl? = nil
    
    private var crawlBars: Array<Bar> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCrawl()
        
        barList.delegate = self
        barList.dataSource = self
        barList.register(UINib(nibName: "DetailedBarCell", bundle: nil), forCellReuseIdentifier: "DetailedBarCell")
        
        topBar.layer.cornerRadius = 2.5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func loadCrawl() {
        crawlName.text = crawl?.data.name
        crawlDuration.text = "Duration: \(crawl?.data.timeframe ?? "Unknown")"
        if let id = crawl?.id {
            crawlBars = CrawlRepository.getAllBarsForCrawlId(id: id)
        }
    }
    
    @IBAction func closeSheet(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "closeSheet"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = self.crawlBars[indexPath.row].id
        let userInfo: [String: String] = ["barId": id]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "barTapped"), object: nil, userInfo: userInfo)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.crawlBars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.barList.dequeueReusableCell(withIdentifier: "DetailedBarCell") as! DetailedBarCell
        let bar = self.crawlBars[indexPath.row]
        cell.barName.text = bar.data.name
        let url = URL(string: bar.data.photoTL)
        cell.barImage.kf.setImage(with: url)
        cell.barInfo.text = bar.data.info
        return cell
    }
}
