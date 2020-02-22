//
//  BarView.swift
//  Crawl
//
//  Created by Jonah Starling on 2/11/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import UIKit

class BarView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var barName: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let barView = UINib(nibName: "BarView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BarView
        barView.frame = self.bounds
        addSubview(barView)
        setupBarView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupBarView() {
        barName.text = "Jonah's Bar"
    }
}
