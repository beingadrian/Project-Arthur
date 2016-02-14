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
    @IBOutlet weak var topBG: TopBGImageView!
    
    // MARK: - Awake from nib
    
    override func awakeFromNib() {
        
        self.backgroundColor = UIColor(
            red: 248/255,
            green: 248/255,
            blue: 248/255,
            alpha: 1)
        
        // table view setup
        self.reportTableView.backgroundView = nil
        self.reportTableView.backgroundColor = UIColor.clearColor()
        
        self.reportTableView.contentInset = UIEdgeInsets(
            top: 15,
            left: 0,
            bottom: 15,
            right: 0)
    
    }
    
    // MARK: -- MenuButtonActions
    @IBAction func menuButtonTapped(sender: UIButton) {
        
        if sender.selected {
            
            sender.selected = false
            
        } else {
            
            sender.selected = true
            
        }
    }
    
    func moveBgByOffset (offset: CGFloat) {
        if offset < 0 {
            let scale = 1.0 - offset/500
            topBG.transform = CGAffineTransformMakeScale(scale, scale)
        }
        
        else {
            topBG.transform = CGAffineTransformMakeScale(1.0, 1.0)
        }
    }

}
