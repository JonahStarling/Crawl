//
//  Bar.swift
//  Crawl
//
//  Created by Jonah Starling on 1/31/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import Foundation

class Bar {
    let name: String
    let info: String
    let lat: Float
    let lon: Float
    var crawls: Set<Crawl>
    var deals: Set<Deal>
    var photos: BarPhotos?
    
    init(name: String,
         info: String,
         lat: Float,
         lon: Float) {
        self.name = name
        self.info = info
        self.lat = lat
        self.lon = lon
        self.crawls = Set()
        self.deals = Set()
        self.photos = nil
    }
    
    func parseCrawls() {
        // TODO: Parse all of the Crawls
    }
    
    func parseDeals() {
        // TODO: Parse all of the Deals
    }
    
    func parsePhotos() -> BarPhotos? {
        // TODO: Parse all of the Photos
        return nil
    }
}
