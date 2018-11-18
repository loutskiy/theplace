//
//  FeatureModel.swift
//  MapIT
//
//  Created by Mikhail Lutskiy on 17/11/2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class ArrayForModel: Mappable {
    var features: [FeatureModel]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        features <- map["features"]
    }
}

class FeatureModel: Mappable {
    
    var attributes: AttributesModel?
    var geometry: GeometryModel?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        attributes <- map["attributes"]
        geometry <- map["geometry"]
    }
    
    
}

class AttributesModel: Mappable {
    var FID: Int?
    var osmId: String?
    var code: Int?
    var fclass: String?
    var name: String?
    var pollution: Double?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        FID <- map["FID"]
        osmId <- map["osm_id"]
        code <- map["code"]
        fclass <- map["fclass"]
        name <- map["name"]
        pollution <- map["pollution"]
    }
}

class GeometryModel: Mappable {
    var x: Double?
    var y: Double?
    var rings: [[[Double]]]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        x <- map["x"]
        y <- map["y"]
        rings <- map["rings"]
    }
}
