//
//  CrawlRepository.swift
//  Crawl
//
//  Created by Jonah Starling on 2/20/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import Foundation
import Firebase

class CrawlRepository {
    
    let crawlRef = FirebaseManager.db.collection("crawls")
    
    func getAllCrawls() -> Array<Crawl> {
        var crawls = Array<Crawl>()
        crawlRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    crawls.append(self.parseCrawl(document: document))
                }
            }
        }
        return crawls
    }
    
    func parseCrawl(document: QueryDocumentSnapshot) -> Crawl {
        let data = document.data()
        do {
        let json = JSONSerialization.data(withJSONObject: data, options: [])
        
        let crawlId = document.documentID
        let crawlName = data["name"] as? String ?? ""
        let crawlInfo = data["info"] as? String ?? ""
        let crawlTimeframe = data["timeframe"] as? String ?? ""
        
        let bars = parseBars(barsArray: barsArray)
            
        } catch <#pattern#> {
            <#statements#>
        }
        
        let newCrawl = Crawl(id: crawlId, name: crawlName)
        return newCrawl
    }
    
    func parseBars(array: NSArray?) -> Array<Bar> {
        var bars = Array<Bar>()
        
        return bars
    }
}
