//
//  CrawlRepository.swift
//  Crawl
//
//  Created by Jonah Starling on 2/20/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase

class CrawlRepository {
    
    private static let crawlRef = FirebaseManager.db.collection("crawls")
    
    static func getAllCrawls() {
        crawlRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let crawlData = try! FirestoreDecoder().decode(CrawlData.self, from: document.data())
                    let crawl = Crawl(id: document.documentID, data: crawlData)
                    Crawls.allCrawls.updateValue(crawl, forKey: crawl.id)
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "allCrawlsLoaded"), object: nil)
            }
        }
    }
    
    static func getCrawl(id: String) -> Crawl? {
        return Crawls.allCrawls[id]
    }
}
