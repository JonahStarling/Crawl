//
//  BottomSheetViewController.swift
//  Crawl
//
//  Created by Jonah Starling on 2/23/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import Foundation

protocol BottomSheet {
    
    func prepareBackgroundView()
    
    func animateOpen()
    
    func dismissBottomSheet()
}
