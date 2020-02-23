//
//  SmallBottomSheetViewController.swift
//  Crawl
//
//  Created by Jonah Starling on 2/23/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import Foundation
import UIKit

class SmallBottomSheetViewController: UIViewController, BottomSheet {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareBackgroundView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        animateOpen()
    }
    
    func prepareBackgroundView() {
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = false

        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: view.layer.cornerRadius).cgPath
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 2.0
    }
    
    func animateOpen() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            let frame = self?.view.frame
            let yComponent: CGFloat = UIScreen.main.bounds.height - 100
            self?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: 100)
        }
    }
    
    func dismissBottomSheet() {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            let frame = self?.view.frame
            let yComponent: CGFloat = UIScreen.main.bounds.height
            self?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: 100)
        }, completion: { _ in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "bottomSheetDismissed"), object: nil)
        })
    }
}
