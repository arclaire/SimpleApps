//
//  ViewHome.swift
//  SimpleApps
//
//  Created by lucy on 13/06/19.
//  Copyright © 2019 lucy. All rights reserved.
//

import UIKit

protocol DelegateViewHome: NSObjectProtocol {
    
    func delegateLoadMore()
    func delegateOpenFilter()
    func delegateOpenHistory()
}

class ViewHome: UIView {

    private var vwHome:UIView!
    //MARK: Outlets
    @IBOutlet weak var colProduct: UICollectionView!
    
    //MARK: Attributes
    weak var delHomeView: DelegateViewHome?
    
    @IBOutlet weak var btnFilter: UIButton!
    var arrProducts: [Product] = [Product]() {
        didSet {
           
            self.reloadUI()
        }
    }
    var isFetching: Bool = false {
        didSet {
           
        }
    }
    var isCanLoadMore: Bool = true
    var intPage = 0
 
    
    //MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.vwHome = self.loadViewFromNIB()
        self.colProduct.delegate = self
        self.colProduct.dataSource = self
        
        if let _ = self.vwHome {
            self.addSubview(self.vwHome)
        }
        self.colProduct.register(UINib(nibName: String(describing: ProductListCell.classForCoder()), bundle: nil), forCellWithReuseIdentifier: String(describing: ProductListCell.classForCoder()))
        
        self.colProduct.register(UINib(nibName: String(describing: BannerCell.classForCoder()), bundle: nil), forCellWithReuseIdentifier: String(describing: BannerCell.classForCoder()))
    }
    
    
    //MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: UI Methods
    func stopAnimationLoad() {
        //self.colProduct.infiniteScrollingView?.stopAnimating()
    }
    
    //MARK: Data Methods
    func reloadUI() {
        self.colProduct.reloadData()
        self.stopAnimationLoad()
    }
    @IBAction func goSearch(_ sender: Any) {
       self.delHomeView?.delegateOpenFilter()
        
    }
    @IBAction func goHistory(_ sender: Any) {
        self.delHomeView?.delegateOpenHistory()
    }
    
    
    
}

extension ViewHome: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension ViewHome: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productCell: ProductListCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductListCell.classForCoder()), for: indexPath) as! ProductListCell
        productCell.setProductUI(withData: self.arrProducts[indexPath.row])
        
        let bannerCell: BannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BannerCell.classForCoder()), for: indexPath) as! BannerCell
        
        if indexPath.row == 0 {
            bannerCell.colBanner.reloadData()
            return bannerCell
        } else {
            return productCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var floatWidthCell:CGFloat = UIScreen.main.bounds.size.width / 2
        var floatHeightCell:CGFloat = floatWidthCell + 120
        if indexPath.row == 0 {
            floatWidthCell =  UIScreen.main.bounds.size.width
            floatHeightCell = 120
        }
        return CGSize(width: floatWidthCell, height: floatHeightCell)
    }
}

