//
//  ServiceProducts.swift
//  SimpleApps
//
//  Created by lucy on 13/06/19.
//  Copyright © 2019 lucy. All rights reserved.
//

import Foundation

class  ServiceProducts {
    #if DEBUG
    private static let BASE_URL: String = "https://ace.tokopedia.com/"
    #else
    private static let BASE_URL: String = "https://ace.tokopedia.com/"
    #endif
    private static let apiClient = AFApiClient()
    
    //MARK: - CallBacks
    typealias callBackGetProduct = ([Product]) -> Void
    typealias callBackError = (Error) -> Void
    
    static func getProductByCategory(sortBy filter: Filter, onsuccess callbackSuccess: @escaping callBackGetProduct, onError: @escaping callBackError ) {
        
        let strUrl: String = "\(BASE_URL)/search/v2.5/product"
        
        var arrProduct: [Product] = [Product]()
        var params: [String : Any] = [:]
        params["q"] = filter.strName
        params["pmin"] = filter.strPMin
        params["pMax"] = filter.strPMax
        params["wholesale"] = filter.isWholeSale
        params["official"] = filter.isOfficialSeller
        params["fshop"] = filter.strTotalGold
        params["start"] = String(filter.intStart)
        params["rows"] = String(filter.intRows)
        
        
        self.apiClient.request(param: params, httpMethod: .get, strUrl: strUrl) { (result) in
            let (jsonData,error) = result
            if let _jsonData = jsonData {
                for data in _jsonData["data"].arrayValue {
                    arrProduct.append(Product(jsonData: data))
                    //debugPrint("ITEM", data)
                }
                callbackSuccess(arrProduct)
            }else {
                onError(error!)
            }
        }
    }
}
