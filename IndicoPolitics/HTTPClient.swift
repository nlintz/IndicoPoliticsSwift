//
//  HTTPClient.swift
//  IndicoPolitics
//
//  Created by Nathan Lintz on 1/9/16.
//  Copyright © 2016 Nathan Lintz. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

public typealias JSONPromise = Promise<NSDictionary>
public protocol HTTPClient {
    func get(url: String, query: [String: AnyObject]) -> JSONPromise
    func post(url: String, data:[String: AnyObject]) -> JSONPromise
}

class RealHTTPClient: HTTPClient {
    func get(url: String, query: [String: AnyObject]) -> JSONPromise {
        return NSURLSession.GET(url, query: query).asDictionary()
    }
    func post(url: String, data:[String: AnyObject]) ->
        
        JSONPromise {
            return JSONPromise {fulfill, reject in
                Alamofire.request(.POST, url, parameters: data, encoding: .JSON).responseJSON(completionHandler: {response in
                    if let res_data = response.result.value as? NSDictionary {
                        fulfill(res_data)
                    }
                })
            }
    }
}
