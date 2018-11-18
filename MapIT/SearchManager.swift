//
//  SearchManager.swift
//  MapIT
//
//  Created by Mikhail Lutskiy on 17/11/2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import Foundation
import NMAKit

class SearchManager {
    
    static let shared = SearchManager()
    
    var bicycleM = 100.0
    var publicTransportM = 100.0
    
    func startSearch() {
        
    }
    
    func makeSearchFor(_ keyword: String) {
        let krakow = NMAGeoCoordinates(latitude: 50.0646501, longitude: 19.9449799)
        let request = NMAPlaces.sharedInstance()?.createSearchRequest(location: krakow, query: keyword)
        request?.collectionSize = 10
        
    }
    
    
}
