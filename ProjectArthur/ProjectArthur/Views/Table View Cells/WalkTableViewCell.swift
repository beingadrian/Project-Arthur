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
    
    var card: RealmCard? {
        didSet {
            
            guard let card = card else {
                return
            }
            
            let description = card.content
            self.descriptionLabel.text = description
            
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .DecimalStyle
            
            let steps = card.adventure!.steps
            self.stepCountLabel.text = formatter.stringFromNumber(steps)
            
            let distance = card.adventure!.miles
            self.distanceLabel.text = formatter.stringFromNumber(distance)
            
        }
    }
    
    // MARK: - Awake from nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundView = nil
        self.backgroundColor = UIColor.clearColor()
        
    }

}
