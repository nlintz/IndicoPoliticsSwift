//
//  Politics.swift
//  IndicoPolitics
//
//  Created by Nathan Lintz on 1/9/16.
//  Copyright © 2016 Nathan Lintz. All rights reserved.
//

import Foundation
import PromiseKit

struct Politics {
    var left: Double
    var right: Double
    var green: Double
    var libertarian: Double
    
}

typealias PoliticsPromise = Promise<Politics>