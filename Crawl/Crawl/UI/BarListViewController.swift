//
//  BarListViewController.swift
//  Crawl
//
//  Created by Jonah Starling on 2/23/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class BarListViewController: StandardBottomSheetViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var barList: UITableView!
    
    private let bars = Array(Bars.allBars.values)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        barList.delegate = self
        barList.dataSource = self
        barList.register(UINib(nibName: "BarCell", bundle: nil), forCellReuseIdentifier: "BarCell")
        
        topBar.layer.cornerRadius = 2.5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func closeSheet(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "closeSheet"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = self.bars[indexPath.row].id
        let userInfo: [String: String] = ["barId": id]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "barTapped"), object: nil, userInfo: userInfo)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Bars.allBars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.barList.dequeueReusableCell(withIdentifier: "BarCell") as! BarCell
        let bar = self.bars[indexPath.row]
        cell.barName.text = bar.data.name
        let url = URL(string: bar.data.photoTL)
        cell.barImage.kf.setImage(with: url)
        return cell
    }
}
