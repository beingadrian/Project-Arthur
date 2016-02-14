//
//  ReportTableViewCell.swift
//  ProjectArthur
//
//  Created by Jimmy Yue on 2/13/16.
//  Copyright © 2016 TheInitiative. All rights reserved.
//

import UIKit

class WalkTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stepCountLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    // MARK: - Awake from nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundView = nil
        self.backgroundColor = UIColor.clearColor()
        
    }

}
