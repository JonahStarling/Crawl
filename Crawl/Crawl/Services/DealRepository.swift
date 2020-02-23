//
//  DealRepository.swift
//  Crawl
//
//  Created by Jonah Starling on 2/20/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase

class DealRepository {
    
    private static let dealRef = FirebaseManager.db.collection("deals")
    
    static func getAllDeals() {
        dealRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let dealData = try! FirestoreDecoder().decode(DealData.self, from: document.data())
                    let deal = Deal(id: document.documentID, data: dealData)
                    Deals.allDeals.updateValue(deal, forKey: deal.id)
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "allDealsLoaded"), object: nil)
            }
        }
    }
    
    static func getDeal(id: String) -> Deal? {
        return Deals.allDeals[id]
    }
}

