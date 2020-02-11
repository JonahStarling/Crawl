//
//  BarPhotos.swift
//  Crawl
//
//  Created by Jonah Starling on 2/7/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import Foundation

class BarPhotos {
    let topRight: Photo
    let topLeft: Photo
    let bottomRight: Photo
    let bottomLeft: Photo
    
    init(topRight: Photo,
         topLeft: Photo,
         bottomRight: Photo,
         bottomLeft: Photo) {
        self.topRight = topRight
        self.topLeft = topLeft
        self.bottomRight = bottomRight
        self.bottomLeft = bottomLeft
    }
    
    class Photo {
        
    }
}
