//
//  BarRepository.swift
//  Crawl
//
//  Created by Jonah Starling on 2/20/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase

class BarRepository {
    
    private static let barRef = FirebaseManager.db.collection("bars")
    
    static func getAllBars() {
        barRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let barData = try! FirestoreDecoder().decode(BarData.self, from: document.data())
                    let bar = Bar(id: document.documentID, data: barData)
                    Bars.allBars.updateValue(bar, forKey: bar.id)
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "allBarsLoaded"), object: nil)
            }
        }
    }
    
    static func getBar(id: String) -> Bar? {
        return Bars.allBars[id]
    }
    
    static func getAllCrawlsForBarId(id: String) -> Array<Crawl> {
        var crawls = Array<Crawl>()
        if let crawlIds = Bars.allBars[id]?.data.crawlIds {
            for crawlId in crawlIds {
                if let crawl = CrawlRepository.getCrawl(id: crawlId) {
                    crawls.append(crawl)
                }
            }
        }
        return crawls
    }
    
    static func getAllDealsForBarId(id: String) -> Array<Deal> {
        var deals = Array<Deal>()
        if let dealIds = Bars.allBars[id]?.data.dealIds {
            for dealId in dealIds {
                if let deal = DealRepository.getDeal(id: dealId) {
                    deals.append(deal)
                }
            }
        }
        return deals
    }
}
