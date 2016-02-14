//
//  EventsTableViewCell.swift
//  ProjectArthur
//
//  Created by Adrian Wisaksana on 2/14/16.
//  Copyright © 2016 TheInitiative. All rights reserved.
//

import UIKit
import RxSwift

class EventsTableViewCell: UITableViewCell {

    var disposeBag = DisposeBag()
    
    // MARK: - Properties
    
    @IBOutlet weak var firstEventLabel: UILabel!
    @IBOutlet weak var secondEventLabel: UILabel!
    @IBOutlet weak var thirdEventLabel: UILabel!
    
    var card: RealmCard? {
        didSet {
            guard let card = card else { return }
            
            switch card.events.count {
            case 0:
                break
            case 1:
                let firstEvent = card.events[0]
                firstEventLabel.text = firstEvent.title
                firstEventLabel.hidden = false
            case 2:
                let firstEvent = card.events[0]
                firstEventLabel.text = firstEvent.title
                firstEventLabel.hidden = false
                let secondEvent = card.events[1]
                secondEventLabel.text = secondEvent.title
                secondEventLabel.hidden = false
            case 3:
                let firstEvent = card.events[0]
                firstEventLabel.text = firstEvent.title
                firstEventLabel.hidden = false
                let secondEvent = card.events[1]
                secondEventLabel.text = secondEvent.title
                secondEventLabel.hidden = false
                let thirdEvent = card.events[2]
                thirdEventLabel.text = thirdEvent.title
                thirdEventLabel.hidden = false
            default:
                break
            }
            
        }
    }
    
    var onCompletedLoadingData = PublishSubject<Void>()
    
    // MARK: - Awake from nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundView = nil
        self.backgroundColor = UIColor.clearColor()
        
        let loadingView = CardLoadingView(superview: self)
        
        firstEventLabel.hidden = true
        secondEventLabel.hidden = true
        thirdEventLabel.hidden = true
        
        LoadingAPI().createEventsCard()
            .observeOn(MainScheduler.instance)
            .subscribeNext { card in
                self.card = card
                loadingView.endAnimation()
                self.onCompletedLoadingData.onNext()
            }
            .addDisposableTo(disposeBag)
        
    }
    
}

extension EventsTableViewCell: LazyLoader {}
