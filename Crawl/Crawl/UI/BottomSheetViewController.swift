//
//  BottomSheetViewController.swift
//  Crawl
//
//  Created by Jonah Starling on 2/23/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import Foundation
import UIKit

class BottomSheetViewController: UIViewController {
    
    private var smallMode: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(BarListViewController.panGesture))
        view.addGestureRecognizer(gesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareBackgroundView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        animateOpen()
    }
    
    @objc func panGesture(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .changed {
            let translation = recognizer.translation(in: self.view)
            var newY = self.view.frame.minY + translation.y
            if newY < 200 {
                newY = 200
            } else if newY > UIScreen.main.bounds.height - 200 {
                newY = UIScreen.main.bounds.height - 200
            }
            self.view.frame = CGRect(x: 0, y: newY, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
        } else if recognizer.state == .ended {
            let y = self.view.frame.minY
            if smallMode {
                if y > UIScreen.main.bounds.height - 220 {
                    // keep in small mode
                    animateToSmallMode()
                } else {
                    // change to big mode
                    animateToBigMode()
                    smallMode = false
                }
            } else {
                if y < 220 {
                    // keep in big mode
                    animateToBigMode()
                } else {
                    // change to small mode
                    animateToSmallMode()
                    smallMode = true
                }
            }
        }
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
        UIView.animate(withDuration: 0.15) { [weak self] in
            let frame = self?.view.frame
            let yComponent: CGFloat = UIScreen.main.bounds.height - 200
            self?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: frame!.height)
        }
    }
    
    func animateToSmallMode() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            let frame = self?.view.frame
            let yComponent: CGFloat = UIScreen.main.bounds.height - 200
            self?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: frame!.height)
        }
    }
    
    func animateToBigMode() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            let frame = self?.view.frame
            let yComponent: CGFloat = 200
            self?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: frame!.height)
        }
    }
    
    func dismissBottomSheet() {
        UIView.animate(withDuration: 0.15, animations: { [weak self] in
            let frame = self?.view.frame
            let yComponent: CGFloat = UIScreen.main.bounds.height
            self?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: frame!.height)
        }, completion: { _ in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "bottomSheetDismissed"), object: nil)
        })
    }
}
