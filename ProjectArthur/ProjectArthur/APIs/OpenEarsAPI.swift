//
//  OpenEarsAPI.swift
//  ProjectArthur
//
//  Created by Jimmy Yue on 2/13/16.
//  Copyright © 2016 TheInitiative. All rights reserved.
//

import Foundation

let affirmativeModel: Set<String> = Set([
    "YES",
    "ALRIGHT",
    "FINE",
    "DEFINITELY",
    "SURE",
    "OK",
    ])

let denialModel: Set<String> = Set([
    "NO",
    "NOPE",
    "NEGATIVE",
    ])

private let languageModel: Array<String> = Array(affirmativeModel) + Array(denialModel)

private let grammarModel = [
    ["YES", "SURE", "ALRIGHT", "FINE", "DEFINITELY", "OK", "NO", "NEGATIVE", "NOPE"]: "OneOfTheseWillBeSaidOnce"
]

//private let grammarModel = [
//    "OneOfTheseWillBeSaidOnce": [
//    "YES",
//    "ALRIGHT",
//    "FINE",
//    "YEA",
//    "AYE",
//    "BY ALL MEANS",
//    "PLEASE DO SO",
//    "CERTAINLY",
//    "DEFINITELY",
//    "OF COURSE",
//    "SURE",
//    "GO FOR IT",
//    "SHOOT",
//    "NO",
//    "NO THANK YOU",
//    "ABSOLUTELY NOT",
//    "NOT TODAY",
//    "NOPE",
//    "NEGATIVE",
//    "I'LL PASS"]]

class OpenEarsAPI {
    private var lmPath: String!
    private var dicPath: String!
    
    let eventObserver: OEEventsObserver
    
    init() {
        eventObserver = OEEventsObserver()
        loadOpenEars()
        setupPSphinx()
        
        //        eventObserver.delegate = self <-- Do this in VC
        
    }
    
    private func loadOpenEars() {
        let lmGenerator = OELanguageModelGenerator()
        let name = "LanguageModelFile"
        
        lmGenerator.generateGrammarFromDictionary(grammarModel, withFilesNamed: name, forAcousticModelAtPath: OEAcousticModel.pathToModel("AcousticModelEnglish"))
        lmGenerator.generateLanguageModelFromArray(languageModel, withFilesNamed: name, forAcousticModelAtPath: OEAcousticModel.pathToModel("AcousticModelEnglish"))
        lmPath = lmGenerator.pathToSuccessfullyGeneratedLanguageModelWithRequestedName(name)
        dicPath = lmGenerator.pathToSuccessfullyGeneratedDictionaryWithRequestedName(name)
    }
    
    func startListening() {
        do {
            try OEPocketsphinxController.sharedInstance().setActive(true)
        }
        catch {
            return
        }
        OEPocketsphinxController.sharedInstance().startListeningWithLanguageModelAtPath(lmPath, dictionaryAtPath: dicPath, acousticModelAtPath: OEAcousticModel.pathToModel("AcousticModelEnglish"), languageModelIsJSGF: false)
    }
    
    func stopListening() {
        OEPocketsphinxController.sharedInstance().stopListening()
    }
    
    private func setupPSphinx() {
        OEPocketsphinxController.sharedInstance().secondsOfSilenceToDetect = 0.5
        OEPocketsphinxController.sharedInstance().vadThreshold = 3.5
    }
}
