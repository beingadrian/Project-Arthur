//
//  ReportTableViewCell.swift
//  ProjectArthur
//
//  Created by Jimmy Yue on 2/13/16.
//  Copyright © 2016 TheInitiative. All rights reserved.
//

import UIKit
import RxSwift

class WalkTableViewCell: UITableViewCell {

    var disposeBag = DisposeBag()
    
    // MARK: - Properties
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stepCountLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var cardView: DesignableView!
    
    var loadingView: CardLoadingView?
    
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
            
            let distance = card.adventure!.distance
            self.distanceLabel.text = formatter.stringFromNumber(distance)
            
        }
    }
    
    // MARK: - Awake from nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundView = nil
        self.backgroundColor = UIColor.clearColor()
        
        LoadingAPI().createWalkCard()
            .subscribeOn(MainScheduler.instance)
            .subscribe(
                onNext: { (card) -> Void in
                    self.card = card
                },
                onError: { (error) -> Void in
                    print("Error creating walk card: \(error)")
                },
                onCompleted: nil,
                onDisposed: nil)
            .addDisposableTo(disposeBag)
        
    }

}
