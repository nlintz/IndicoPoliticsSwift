//
//  IndicoDeserializer.swift
//  IndicoPolitics
//
//  Created by Nathan Lintz on 1/9/16.
//  Copyright © 2016 Nathan Lintz. All rights reserved.
//

import Foundation
import PromiseKit

struct IndicoDeserializationError: ErrorType {
    var description: String
}

protocol PoliticalDeserializer {
    func deserialize(representation: NSDictionary) -> PoliticsPromise
}

class RealPoliticsDeserializer: PoliticalDeserializer {
    func deserialize(representation: NSDictionary) -> PoliticsPromise {
        let promise = PoliticsPromise { fulfill, reject in
            
            guard let features = representation["results"] as? [String: AnyObject]
                else {
                    let error = IndicoDeserializationError(description: "JSON response does not contain list of results: \(representation)")
                    reject(error)
                    return
            }
            
            do {
                let politics = try self.deserializePolitics(features)
                fulfill(politics)
            } catch let error {
                reject(error)
            }
        }
        return promise
        
        
    }
    
    private func deserializePolitics(representation: NSDictionary) throws -> Politics {
        let left = representation["Liberal"] as? Double
        let right = representation["Conservative"] as? Double
        let green = representation["Green"] as? Double
        let libertarian = representation["Libertarian"] as? Double

        return Politics(left: left!, right: right!, green: green!, libertarian: libertarian!)
        
    }
}
