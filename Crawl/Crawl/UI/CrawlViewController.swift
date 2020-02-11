//
//  CrawlViewController.swift
//  Crawl
//
//  Created by Jonah Starling on 2/11/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import UIKit

class CrawlViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(CrawlViewController.panGesture))
        view.addGestureRecognizer(gesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCrawl()
        prepareBackgroundView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        UIView.animate(withDuration: 0.3) { [weak self] in
            let frame = self?.view.frame
            let yComponent: CGFloat = UIScreen.main.bounds.height - 200
            self?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: frame!.height)
        }
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
            if y < UIScreen.main.bounds.height * 0.5 {
                UIView.animate(withDuration: 0.3) { [weak self] in
                    let frame = self?.view.frame
                    let yComponent: CGFloat = 200
                    self?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: frame!.height)
                }
            } else {
                UIView.animate(withDuration: 0.3) { [weak self] in
                    let frame = self?.view.frame
                    let yComponent: CGFloat = UIScreen.main.bounds.height - 200
                    self?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: frame!.height)
                }
            }
        }
    }
    
    func loadCrawl() {
    }
    
    func prepareBackgroundView() {
        let crawlView = CrawlView.init(frame: UIScreen.main.bounds)
        
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.insertSubview(crawlView, at: 0)
    }
    
}
