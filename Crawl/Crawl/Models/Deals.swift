//
//  Deal.swift
//  Crawl
//
//  Created by Jonah Starling on 1/31/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import Foundation

class Deals {
    static var allDeals = Dictionary<String, Deal>()
}

struct Deal {
    let id: String
    var data: DealData
}

struct DealData: Codable {
    var name: String
    var timeframe: String
}
