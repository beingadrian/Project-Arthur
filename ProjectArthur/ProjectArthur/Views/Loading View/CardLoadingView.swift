//
//  CardLoadingView.swift
//  ProjectArthur
//
//  Created by Adrian Wisaksana on 2/14/16.
//  Copyright © 2016 TheInitiative. All rights reserved.
//

import Foundation
import UIKit

class CardLoadingView: UIView {
    
    init(superview: UIView) {
        super.init(frame: superview.frame)
        
        self.backgroundColor = UIColor.whiteColor()
            .colorWithAlphaComponent(1)
        
        superview.addSubview(self)
        
        self.frame.origin = superview.frame.origin
        superview.clipsToBounds = true
        
        animate()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func animate() {
        
        UIView.animateWithDuration(
            1,
            delay: 0,
            options: [.Repeat, .Autoreverse],
            animations: { () -> Void in
                self.alpha = 0.8
            },
            completion: nil)
        
    }
    
    func endAnimation() {
        
        UIView.animateWithDuration(
            1,
            delay: 0,
            options: [.CurveEaseIn],
            animations: { () -> Void in
                self.alpha = 0
            }) { finished in
                if finished {
                    self.removeFromSuperview()
                }
            }
        
    }
    
}