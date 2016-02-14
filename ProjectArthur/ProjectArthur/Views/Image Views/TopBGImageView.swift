//
//  TopBGImageView.swift
//  ProjectArthur
//
//  Created by Jimmy Yue on 2/13/16.
//  Copyright © 2016 TheInitiative. All rights reserved.
//

import UIKit

class TopBGImageView: UIImageView {

//    private enum State {
//        case Dark
//        case Lite
//    }
//    
//    private var state = State.Dark
    
    func setAsDark() {
        self.image = UIImage(named: "BGDark")
    }
    
    func setAsLite() {
        self.image = UIImage(named: "BGLite")
    }
    
//    func toggleState() {
//        switch state {
//        case .Dark:
//            self.image = UIImage(named: <#T##String#>)
//            
//        case .Lite:
//            
//            
//        }
//    }

}
