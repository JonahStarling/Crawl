//
//  Deal.swift
//  Crawl
//
//  Created by Jonah Starling on 1/31/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import Foundation

class Deals {
    var allDeals = Dictionary<String, Deal>()
}

struct Deal: Codable {
    let id: String
    let name: String
    let timeframe: String
}
