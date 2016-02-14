//
//  ReportViewModel.swift
//  ProjectArthur
//
//  Created by Adrian Wisaksana on 2/14/16.
//  Copyright © 2016 TheInitiative. All rights reserved.
//

import Foundation
import RxSwift

class ReportViewModel {
    
    var disposeBag = DisposeBag()
    
    // MARK: - Properties
    
    var owner: UIViewController
    
    var cells: [UITableViewCell] = []
    
    // MARK: - Initialization
    
    init(owner: UIViewController) {
        
        self.owner = owner
        
        let walkNib = UINib(nibName: "WalkTableViewCell", bundle: nil)
        let walkCell = walkNib.instantiateWithOwner(owner, options: nil).first as! WalkTableViewCell
        
        let questNib = UINib(nibName: "QuestTableViewCell", bundle: nil)
        let questCell = questNib.instantiateWithOwner(owner, options: nil).first as! QuestTableViewCell
        
        let eventsNib = UINib(nibName: "EventsTableViewCell", bundle: nil)
        let eventsCell = eventsNib.instantiateWithOwner(owner, options: nil).first as! EventsTableViewCell
        
        cells.append(walkCell)
        cells.append(questCell)
        cells.append(eventsCell)
        
    }
    
    private func createWalkCard() {
        
        
        
    }
    
    private func createQuestCard() {
        
        
        
    }
    
}