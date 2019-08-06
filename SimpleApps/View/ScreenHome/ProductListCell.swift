//
//  ProductListCell.swift
//  SimpleApps
//
//  Created by lucy on 13/06/19.
//  Copyright © 2019 lucy. All rights reserved.
//


import UIKit

class ProductListCell: UICollectionViewCell {
    
  @IBOutlet weak var imgProduct: UIImageView!
  @IBOutlet weak var imgBadge: UIImageView!
  
  @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setProductUI(withData _product: Product) {
      self.lblTitle.text = _product.strName
      self.lblPrice.text = _product.strPrice
      self.imgProduct.setImage(source: _product.strImageItemUrl, type: .general, contentMode: .scaleAspectFill)
//      self.imgProduct.setImage(source: _product.strImageItemUrl, type: .general, contentMode: .scaleAspectFill)
//      if _product.shop.strImageReputationUrl.count > 1 {
//        self.imgBadge.setImage(source: _product.shop.strImageReputationUrl, type: .general, contentMode: .scaleAspectFit)
//      }
    }
    
}
