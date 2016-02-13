//
//  ArthurViewController.swift
//  ProjectArthur
//
//  Created by Jimmy Yue on 2/13/16.
//  Copyright © 2016 TheInitiative. All rights reserved.
//

import UIKit

class ArthurViewController: UIViewController {
    
    var openEars: OpenEarsAPI!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        // Do any additional setup after loading the view.
    }
    
    private func setup() {
        openEars = OpenEarsAPI()
        openEars.eventObserver.delegate = self // Needed to access events
        
        // Testing:
        openEars.startListening()
        
    }
    
}

extension ArthurViewController: OEEventsObserverDelegate {
    
    func pocketsphinxDidStartListening() {
        print("Pocketsphinx is now listening.")
    }
    
    func pocketsphinxDidDetectSpeech() {
        print("Pocketsphinx has detected speech.")
    }
    
    func pocketsphinxDidDetectFinishedSpeech() {
        print("Pocketsphinx has detected a period of silence, concluding an utterance.")
    }
    
    func pocketsphinxDidStopListening() {
        print("Pocketsphinx has stopped listening.")
    }
    
    func pocketsphinxDidSuspendRecognition() {
        print("Pocketsphinx has suspended recognition.")
    }
    
    func pocketsphinxDidResumeRecognition() {
        print("Pocketsphinx has resumed recognition.")
    }
    
    func pocketsphinxDidChangeLanguageModelToFile(newLanguageModelPathAsString: String, newDictionaryPathAsString: String) {
        print("Pocketsphinx is now using the following language model: \(newLanguageModelPathAsString) and the following dictionary: \(newDictionaryPathAsString)")
    }
    
    func pocketSphinxContinuousSetupDidFailWithReason(reasonForFailure: String) {
        print("Listening setup wasn't successful and returned the failure reason: \(reasonForFailure)")
    }
    
    func pocketSphinxContinuousTeardownDidFailWithReason(reasonForFailure: String) {
        print("Listening teardown wasn't successful and returned the failure reason: \(reasonForFailure)")
    }
    
    func pocketsphinxFailedNoMicPermissions() {
        NSLog("Local callback: The user has never set mic permissions or denied permission to this app's mic, so listening will not start.")
        if OEPocketsphinxController.sharedInstance().isListening {
            let error = OEPocketsphinxController.sharedInstance().stopListening() // Stop listening if we are listening.
            if(error != nil) {
                NSLog("Error while stopping listening in micPermissionCheckCompleted: %@", error);
            }
        }
    }
    
    func pocketsphinxDidReceiveHypothesis(hypothesis: String!, recognitionScore: String!, utteranceID: String!) {
        print("Heard: \(hypothesis)\nRecognitionScore: \(recognitionScore)")
    }
    
}

