//
//  LazyLoader.swift
//  ProjectArthur
//
//  Created by Adrian Wisaksana on 2/14/16.
//  Copyright © 2016 TheInitiative. All rights reserved.
//

import Foundation
import RxSwift

protocol LazyLoader: class {
    
    var onCompletedLoadingData: PublishSubject<Void> { get set }
    
}