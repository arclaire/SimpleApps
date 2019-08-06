//
//  ViewFilter.swift
//  SimpleApps
//
//  Created by lucy on 14/06/19.
//  Copyright © 2019 lucy. All rights reserved.
//


import UIKit


protocol DelegateViewFilter: NSObjectProtocol {
  
  func delegateApplyFilter(data: Filter)
  func delegateDismissFilter()
}

class ViewFilter: UIView {

  private var vwFilter:UIView!
  
    @IBOutlet weak var vwActivity: UIActivityIndicatorView!
    
    @IBOutlet weak var textSearch: UITextField!
    var filter: Filter = Filter(jsonData: "")
 
  
    @IBOutlet weak var colProduct: UICollectionView!
    weak var delVwFilter: DelegateViewFilter?
    
    var arrProducts: [Product] = [Product]() {
        didSet {
            self.reloadUI()
        }
    }
  //MARK: Initialization
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    
    self.vwFilter = self.loadViewFromNIB()
    if let _ = self.vwFilter {
      self.addSubview(self.vwFilter)
    }
  }
  
  //MARK: - Lifecycle
  override func awakeFromNib() {
    super.awakeFromNib()
    self.colProduct.delegate = self
    self.colProduct.dataSource = self
     self.colProduct.register(UINib(nibName: String(describing: ProductListCell.classForCoder()), bundle: nil), forCellWithReuseIdentifier: String(describing: ProductListCell.classForCoder()))

  }
  
  //MARK: - UI Methods
    func reloadUI() {
        self.vwActivity.stopAnimating()
        self.vwActivity.isHidden = true
        self.colProduct.reloadData()
    }
    func prepareUI(data filter: Filter) {
        self.filter = filter
   
    }
  
    @IBAction func doSearch(_ sender: Any) {
        self.endEditing(true)
        self.callApi()
    }
    
    func callApi() {
        self.filter.intStart = 0
        self.vwActivity.startAnimating()
        self.vwActivity.isHidden = false
        if let strText = self.textSearch.text {
            self.filter.strName = strText
            ServiceProducts.getProductByCategory(sortBy: filter, onsuccess: { (product) in
                self.arrProducts = [Product]()
                if product.count > 0 {
                    
                    self.arrProducts += product
                    self.reloadUI()
                } else {
                    
                }
            }) { (error) in
                self.reloadUI()
            }
        }
        
        
    }
}

extension ViewFilter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
}

extension ViewFilter: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productCell: ProductListCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductListCell.classForCoder()), for: indexPath) as! ProductListCell
        productCell.setProductUI(withData: self.arrProducts[indexPath.row])
        return productCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var floatWidthCell:CGFloat = UIScreen.main.bounds.size.width / 2
        var floatHeightCell:CGFloat = floatWidthCell + 120
        return CGSize(width: floatWidthCell, height: floatHeightCell)
    }
}

