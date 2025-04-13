//
//  ProductCollectionViewCell.swift
//  MazaadyIOSTask
//
//  Created by Mac on 11/04/2025.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var minutesNumber: UILabel!
    @IBOutlet weak var daysNumber: UILabel!
    @IBOutlet weak var hoursNumber: UILabel!
    @IBOutlet weak var productPriceOffer: UILabel!
    @IBOutlet weak var productPriceBeforeOffer: UILabel!
    @IBOutlet weak var productPriceText: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var cellOuterView: UIView!
    @IBOutlet weak var offerCountDownStack: UIStackView!
    @IBOutlet weak var specialOfferStack: UIStackView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func cellConfigure(hide:Bool) {
        cellOuterView.layer.cornerRadius = 15
        offerCountDownStack.layer.cornerRadius = 15
        

        offerCountDownStack.isHidden = hide
        specialOfferStack.isHidden = hide
    }
}
