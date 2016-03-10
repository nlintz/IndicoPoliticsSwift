//
//  IndicoIO.swift
//  IndicoPolitics
//
//  Created by Nathan Lintz on 1/9/16.
//  Copyright © 2016 Nathan Lintz. All rights reserved.
//

import Foundation
import PromiseKit

class IndicoIO {
    let httpClient: HTTPClient
    let politicalDeserializer: PoliticalDeserializer

    init(httpClient: HTTPClient = RealHTTPClient(), politicalDeserializer: RealPoliticsDeserializer = RealPoliticsDeserializer()) {
        self.httpClient = httpClient
        self.politicalDeserializer = politicalDeserializer
    }

    func political(text: String) -> PoliticsPromise {
        let url = "https://apiv2.indico.io/political?key=<MY_INDICO_KEY>"
        let data: [String: AnyObject] = ["data": text]
        

        return httpClient.post(url, data: data).thenInBackground { representation -> PoliticsPromise in
            return self.politicalDeserializer.deserialize(representation)
        }
    }
}