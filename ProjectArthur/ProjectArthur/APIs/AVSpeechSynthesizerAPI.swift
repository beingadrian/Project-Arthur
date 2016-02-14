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
        let speechUtterance = AVSpeechUtterance(string: "There is no absolute rule: very short or long paragraphs can work when used by an experienced writer. However, as a guideline, paragraphs should usually be no less that 2 or 3 sentences long and there should be 2 or 3 paragraphs per page of A4.")
        speechUtterance.voice = AVSpeechSynthesisVoice(identifier: AVSpeechSynthesisVoiceIdentifierAlex)
        print(speechUtterance.voice)
        synth.speakUtterance(speechUtterance)
    }
    
    
}
