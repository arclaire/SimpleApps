//
//  VCHome.swift
//  SimpleApps
//
//  Created by lucy on 13/06/19.
//  Copyright © 2019 lucy. All rights reserved.
//

import UIKit

class VCHome: UIViewController {

    var filter: Filter = Filter.init(jsonData: "")
    @IBOutlet var vwHome: ViewHome!
    var isLogin = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwHome.delHomeView = self
        self.callApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !self.isLogin {
            self.isLogin = true
            self.performSegue(withIdentifier: "openLogin", sender: self)
        }
        
    }
    //MARK: - SERVICES
    func callApi() {
        self.filter.intStart = self.vwHome.intPage
        debugPrint("Start From", self.vwHome.intPage)
        ServiceProducts.getProductByCategory(sortBy: filter, onsuccess: { (product) in
            if product.count > 0 {
                self.vwHome.arrProducts += product
                //self.vwHome.reloadUI()
            } else {
                self.vwHome.isFetching = false
            }
            self.vwHome.stopAnimationLoad()
        }) { (error) in
            self.vwHome.isFetching = false
            self.vwHome.stopAnimationLoad()
        }
    }
    
    func callApiForSearch(search txt: String) {
        self.filter.intStart = 0
        self.filter.strName = txt
        ServiceProducts.getProductByCategory(sortBy: filter, onsuccess: { (product) in
            if product.count > 0 {
                self.vwHome.colProduct.isHidden = false
                self.vwHome.arrProducts = product
                self.vwHome.reloadUI()
            } else {
                self.vwHome.colProduct.isHidden = true
            }
        }) { (error) in
        }
    }

    
}

extension VCHome: DelegateViewHome {
    func delegateOpenFilter() {
         self.performSegue(withIdentifier: "openFilter", sender: self)
    }
    
    func delegateLoadMore() {
        
    }
    
    func delegateOpenHistory() {
        self.performSegue(withIdentifier: "openHistory", sender: self)
    }
}
