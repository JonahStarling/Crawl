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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initBarView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initBarView()
    }
    
    func initBarView() {
        Bundle(for: type(of: self)).loadNibNamed("BarView", owner: self, options: nil)
        view.frame = self.bounds
        addSubview(view)
    }
}
