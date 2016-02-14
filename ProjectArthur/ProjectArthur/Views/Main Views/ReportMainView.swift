//
//  ReportMainView.swift
//  ProjectArthur
//
//  Created by Jimmy Yue on 2/13/16.
//  Copyright © 2016 TheInitiative. All rights reserved.
//

import UIKit

class ReportMainView: UIView {
    
    // MARK: - Outlets
    @IBOutlet weak var reportTableView: UITableView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var topBG: TopBGImageView!
    
    // MARK: -- MenuButtonActions
    @IBAction func menuButtonTapped(sender: UIButton) {
        
        if sender.selected {
            
            sender.selected = false
            
        } else {
            
            sender.selected = true
            
        }
    }

}
