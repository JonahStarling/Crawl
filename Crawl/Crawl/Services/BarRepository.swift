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
}
