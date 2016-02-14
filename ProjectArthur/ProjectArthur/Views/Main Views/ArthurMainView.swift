//
//  ArthurMainView.swift
//  ProjectArthur
//
//  Created by Jimmy Yue on 2/13/16.
//  Copyright © 2016 TheInitiative. All rights reserved.
//

import UIKit
import QuartzCore

class ArthurMainView: UIView {
    
    let screenBounds = UIScreen.mainScreen().bounds
    
    @IBOutlet weak var arthurImageView: UIImageView!
    @IBOutlet weak var shadowImageView: UIImageView!
    
    // Outlets for animation purposes
    @IBOutlet weak var arthurYConstraint: NSLayoutConstraint!
    var pulseView: UIView!
    
    func loadIn() {
        
        // Set the stage
        arthurImageView.hidden = false
        shadowImageView.hidden = false
        
        arthurImageView.alpha = 0.0
        shadowImageView.alpha = 0.0
        
        arthurYConstraint.constant = -(screenBounds.height/5)
        shadowImageView.transform = CGAffineTransformMakeScale(0.2, 0.2)
        self.layoutIfNeeded()
        
        UIView.animateWithDuration(0.75, delay: 0.25, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.arthurImageView.alpha = 1.0
                self.shadowImageView.alpha = 1.0
                self.arthurYConstraint.constant = 0
                self.shadowImageView.transform = CGAffineTransformMakeScale(1.0, 1.0)
                self.layoutIfNeeded()
            }, completion: { Void in
                self.idle()
//                self.pulseFromSpeaking()
        })
        
    }
    
    func idle() {
        
        UIView.animateWithDuration(1.5, delay: 0.0, options: [UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.Repeat, UIViewAnimationOptions.CurveEaseInOut], animations: {
            self.arthurYConstraint.constant = (self.screenBounds.height/50)
            self.shadowImageView.transform = CGAffineTransformMakeScale(1.05, 1.05)
            self.layoutIfNeeded()
            }, completion: nil)
    }
    
    func pulseFromSpeaking() {
        
        pulseView = UIView(frame: CGRectMake(200, 200, 100, 100))
        pulseView.layer.cornerRadius = 50
        pulseView.layer.borderColor = UIColor(red: 170/255, green: 200/255, blue: 255/255, alpha: 1.0).CGColor
        pulseView.layer.borderWidth = 1
        pulseView.backgroundColor = UIColor.clearColor()
        pulseView.center = arthurImageView.center
        
        self.insertSubview(pulseView, atIndex: 0)
        
        let scaleAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        let alphaAnimation:CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        
        scaleAnimation.duration = 2.0
        scaleAnimation.repeatCount = 999.0
        scaleAnimation.fromValue = 0.0
        scaleAnimation.toValue = 4.0
        
        alphaAnimation.duration = 2.0
        alphaAnimation.repeatCount = 999.0
        alphaAnimation.fromValue = 1.0
        alphaAnimation.toValue = 0.0
        
        pulseView.layer.addAnimation(scaleAnimation, forKey: "scale")
        pulseView.layer.addAnimation(alphaAnimation, forKey: "alpha")
    }
    
    func stopPulseFromSpeaking() {
        
        pulseView.removeFromSuperview()
        pulseView = nil
    }

}
