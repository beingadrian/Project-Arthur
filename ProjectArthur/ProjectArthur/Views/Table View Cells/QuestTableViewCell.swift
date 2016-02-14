//
//  QuestTableViewCell.swift
//  ProjectArthur
//
//  Created by Adrian Wisaksana on 2/14/16.
//  Copyright © 2016 TheInitiative. All rights reserved.
//

import UIKit
import RxSwift

class QuestTableViewCell: UITableViewCell {

    var disposeBag = DisposeBag()
    
    // MARK: - Properties
    
    @IBOutlet weak var firstQuestLabel: UILabel!
    @IBOutlet weak var secondQuestLabel: UILabel!
    @IBOutlet weak var thirdQuestLabel: UILabel!
    
    var card: RealmCard? {
        didSet {
            guard let card = card else { return }
            
            switch card.quests.count {
            case 0:
                break
            case 1:
                let firstQuest = card.quests[0]
                firstQuestLabel.text = firstQuest.title
                firstQuestLabel.hidden = false
            case 2:
                let firstQuest = card.quests[0]
                firstQuestLabel.text = firstQuest.title
                firstQuestLabel.hidden = false
                let secondQuest = card.quests[1]
                secondQuestLabel.text = secondQuest.title
                secondQuestLabel.hidden = false
            case 3:
                let firstQuest = card.quests[0]
                firstQuestLabel.text = firstQuest.title
                firstQuestLabel.hidden = false
                let secondQuest = card.quests[1]
                secondQuestLabel.text = secondQuest.title
                secondQuestLabel.hidden = false
                let thirdQuest = card.quests[2]
                thirdQuestLabel.text = thirdQuest.title
                thirdQuestLabel.hidden = false
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
        
        firstQuestLabel.hidden = true
        secondQuestLabel.hidden = true
        thirdQuestLabel.hidden = true
        
        LoadingAPI().createQuestCard()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { (card) -> Void in
                    self.card = card
                    self.onCompletedLoadingData.onNext()
                },
                onError: { (error) -> Void in
                    print("Error creating quest card: \(error)")
                },
                onCompleted: nil,
                onDisposed: nil)
            .addDisposableTo(disposeBag)
        
    }
    
}

extension QuestTableViewCell: LazyLoader {}
