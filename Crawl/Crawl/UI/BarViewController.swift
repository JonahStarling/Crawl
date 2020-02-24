//
//  BarViewController.swift
//  Crawl
//
//  Created by Jonah Starling on 2/10/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import UIKit
import Kingfisher

class BarViewController: StandardBottomSheetViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var barName: UILabel!
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var barInfo: UILabel!
    
    @IBOutlet weak var barTL: UIImageView!
    @IBOutlet weak var barTR: UIImageView!
    @IBOutlet weak var barBL: UIImageView!
    @IBOutlet weak var barBR: UIImageView!
    
    @IBOutlet weak var crawlAndDealList: UITableView!
    
    var bar: Bar? = nil
    
    private var crawls: Array<Crawl> = Array()
    private var deals: Array<Deal> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBar()
        
        crawlAndDealList.delegate = self
        crawlAndDealList.dataSource = self
        crawlAndDealList.register(UINib(nibName: "CrawlCell", bundle: nil), forCellReuseIdentifier: "CrawlCell")
        crawlAndDealList.register(UINib(nibName: "DealCell", bundle: nil), forCellReuseIdentifier: "DealCell")
        crawlAndDealList.register(UINib(nibName: "CrawlHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "CrawlHeader")
        crawlAndDealList.register(UINib(nibName: "DealHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "DealHeader")
        
        topBar.layer.cornerRadius = 2.5
        
        barTL.layer.cornerRadius = 4
        barTR.layer.cornerRadius = 4
        barBL.layer.cornerRadius = 4
        barBR.layer.cornerRadius = 4
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func loadBar() {
        barName.text = bar?.data.name
        barInfo.text = bar?.data.info
        
        barTL.kf.setImage(with: URL(string: bar?.data.photoTL ?? ""))
        
        barTR.kf.setImage(with: URL(string: bar?.data.photoTR ?? ""))
        barBL.kf.setImage(with: URL(string: bar?.data.photoBL ?? ""))
        barBR.kf.setImage(with: URL(string: bar?.data.photoBR ?? ""))
        
        if let id = bar?.id {
            crawls = BarRepository.getAllCrawlsForBarId(id: id)
            deals = BarRepository.getAllDealsForBarId(id: id)
        }
    }
    
    @IBAction func closeSheet(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "closeSheet"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let id = self.crawls[indexPath.row].id
            let userInfo: [String: String] = ["crawlId": id]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "crawlTapped"), object: nil, userInfo: userInfo)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return crawls.count
        } else {
            return deals.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return self.crawlAndDealList.dequeueReusableHeaderFooterView(withIdentifier: "CrawlHeader") as! CrawlHeader
        } else {
            return self.crawlAndDealList.dequeueReusableHeaderFooterView(withIdentifier: "DealHeader") as! DealHeader
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = self.crawlAndDealList.dequeueReusableCell(withIdentifier: "CrawlCell") as! CrawlCell
            let crawl = self.crawls[indexPath.row]
            cell.crawlName.text = crawl.data.name
            cell.crawlDuration.text = "Duration: \(crawl.data.timeframe)"
            let bars = CrawlRepository.getAllBarsForCrawlId(id: crawl.id)
            cell.crawlBars.text = "Bars: \(getConcatenatedBarNames(bars: bars))"
            return cell
        } else {
            let cell = self.crawlAndDealList.dequeueReusableCell(withIdentifier: "DealCell") as! DealCell
            let deal = self.deals[indexPath.row]
            cell.dealName.text = deal.data.name
            cell.dealTimeframe.text = deal.data.timeframe
            return cell
        }
    }
    
    func getConcatenatedBarNames(bars: Array<Bar>) -> String {
        var barNames = Array<String>()
        for bar in bars {
            barNames.append(bar.data.name)
        }
        return barNames.joined(separator: ", ")
    }
}
