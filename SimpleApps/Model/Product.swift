//
//  Product.swift
//  SimpleApps
//
//  Created by lucy on 13/06/19.
//  Copyright © 2019 lucy. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Product {
    var strId: String = ""
    var strName: String = "-"
    var strPrice: String = "-"
    var strImageItemUrl: String = ""
    var strImagePlaceHolder = "placeholder_item"
    var isGoldSeller: Bool = false
    var isShowBadge: Bool = false
    
    init(jsonData: JSON) {
        self.strId = jsonData["id"].stringValue
        self.strPrice = jsonData["price"].stringValue
        self.strName = jsonData["name"].stringValue
        self.strImageItemUrl = jsonData["image_uri"].stringValue
        self.isGoldSeller = jsonData["is_gold"].boolValue
        
    }
}
