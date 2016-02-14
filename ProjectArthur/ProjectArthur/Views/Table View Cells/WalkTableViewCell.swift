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
            
            guard let description = card.values["description"] as? String else { return }
            self.descriptionLabel.text = description
            
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .DecimalStyle
            
            guard let steps = card.values["steps"] as? Double else { return }
            self.stepCountLabel.text = formatter.stringFromNumber(steps)
            
            guard let distance = card.values["distance"] as? Double else {
                return
            }
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
