//
//  AVSpeechSynthesizerAPI.swift
//  ProjectArthur
//
//  Created by Jimmy Yue on 2/13/16.
//  Copyright © 2016 TheInitiative. All rights reserved.
//

import Foundation
import AVFoundation

class AVSpeechSynthesizerAPI {
    
    enum Error: ErrorType {
        case RequestAccessError(error: NSError?)
        case RequestAccessNotGranted
        case SpeechSynthError(error: NSError?)
    }
    
    private let synth = AVSpeechSynthesizer()
    
    /*
    * In the future, use RealmCards (or something similar) instead of [String:AnyObject]s. The app runs entirely on the internal database, and as such, passing the "queue" of cards is only reasonably done from internally. This way, there will be a more solid system of parsing. Inside this function, create an "AVSpeechUtterance" class, and use that to approach the vocalization of your cards.
    */
//    func speak(cards: [String:AnyObject]) {
//        
//    }
    
    func speechTest() {
//        let utter = AVUt
    }
    
    
}
