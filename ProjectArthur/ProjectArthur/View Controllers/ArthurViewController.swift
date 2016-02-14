//
//  ArthurViewController.swift
//  ProjectArthur
//
//  Created by Jimmy Yue on 2/13/16.
//  Copyright © 2016 TheInitiative. All rights reserved.
//

import UIKit

class ArthurViewController: UIViewController {
    
    private var openEars: OpenEarsAPI!
    private var speechAPI: AVSpeechSynthesizerAPI!
    
    private enum State {
        case Introduction
        case HearReportQuery
        case Report
        case Music
        case Finished
    }
    
    private var state = State.Introduction
    
    @IBOutlet weak var mainView: ArthurMainView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(animated: Bool) {
        mainView.loadIn()
        speechAPI.dailyPrompt()
    }
    
    private func setup() {
        openEars = OpenEarsAPI()
        openEars.eventObserver.delegate = self // Needed to access events
        
        speechAPI = AVSpeechSynthesizerAPI()
        speechAPI.synth.delegate = self
        
        
        // Testing:
//        openEars.startListening()
//        speechAPI.dailyPrompt()
        
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
//        print("Heard: \(hypothesis.characters.split{$0 == " "}.map(String.init).last)\nRecognitionScore: \(recognitionScore)")
        let heard = hypothesis.characters.split{$0 == " "}.map(String.init).last
        let affirmation = affirmativeModel.contains(heard!)
        openEars.stopListening()
        switch state {
        case .HearReportQuery:
            if !affirmation {
                state = .Finished
                break
                // Do finishing stuff here
            }
            state = .Report
            speechAPI.sayReport()
        default:
            break
        }
    }
    
}

extension ArthurViewController: AVSpeechSynthesizerDelegate {
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didStartSpeechUtterance utterance: AVSpeechUtterance) {
        mainView.pulseFromSpeaking()
    }
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didFinishSpeechUtterance utterance: AVSpeechUtterance) {
        mainView.stopPulseFromSpeaking()
        switch state {
        case .Introduction:
            openEars.startListening()
            state = .HearReportQuery
        case .Report:
            state = .Finished
            // Do finishing stuff here
        default:
            break
        }
    }
}

