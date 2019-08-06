//
//  VCFilter.swift
//  SimpleApps
//
//  Created by lucy on 14/06/19.
//  Copyright © 2019 lucy. All rights reserved.
//


import UIKit

protocol DelegateVCFilter: NSObjectProtocol {
  func delegateFilter(data: Filter)
  
}


class VCFilter: UIViewController {
  
  @IBOutlet var vwFilter: ViewFilter!
  
  var filter: Filter = Filter(jsonData: "")
  weak var delVcFilter: DelegateVCFilter?
  override func viewDidLoad() {
    
    super.viewDidLoad()
    self.vwFilter.delVwFilter = self
    self.vwFilter.filter = self.filter
    self.vwFilter.prepareUI(data: self.filter)
   
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated)
   
  }
  
  
  override func viewWillDisappear(_ animated: Bool) {
    
    super.viewWillDisappear(animated)
    
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    
    super.viewDidDisappear(animated)
    
  }
  
  override func didReceiveMemoryWarning() {
    
    super.didReceiveMemoryWarning()
    
  }
}

extension VCFilter: DelegateViewFilter {
  func delegateDismissFilter() {
    self.dismiss(animated: true) {
      
    }
  }
  
  func delegateApplyFilter(data: Filter) {
    self.delVcFilter?.delegateFilter(data: data)
    self.dismiss(animated: true)
  }
}
