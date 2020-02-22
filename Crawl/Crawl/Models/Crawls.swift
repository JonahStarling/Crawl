//
//  Crawl.swift
//  Crawl
//
//  Created by Jonah Starling on 1/31/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import Foundation

class Crawls {
    static var allCrawls = Dictionary<String, Crawl>()
}

struct Crawl {
    let id: String
    var data: CrawlData
}

struct CrawlData: Codable {
    var name: String
    var info: String
    var timeframe: String
    var barIds: Array<String>
}
