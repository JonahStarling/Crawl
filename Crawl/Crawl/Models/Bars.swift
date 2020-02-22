//
//  Bar.swift
//  Crawl
//
//  Created by Jonah Starling on 1/31/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import Foundation

class Bars {
    static var allBars = Dictionary<String, Bar>()
}

struct Bar {
    let id: String
    var data: BarData
}

struct BarData: Codable {
    let name: String
    let info: String
    let lat: Float
    let lon: Float
    var crawlIds: Array<String>
    var dealIds: Array<String>
    var thumbnailTL: String
    var thumbnailTR: String
    var thumbnailBL: String
    var thumbnailBR: String
    var photoTL: String
    var photoTR: String
    var photoBL: String
    var photoBR: String
}
