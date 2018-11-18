//
//  FavoriteModel.swift
//  MapIT
//
//  Created by Mikhail Lutskiy on 17/11/2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import Foundation
import RealmSwift
import NMAKit

class FavoriteModel: Object {
    @objc dynamic var latitude = 0.0
    @objc dynamic var longitude = 0.0
    @objc dynamic var bicycleM = 0
    @objc dynamic var publicTransportM = 0
}
