//
//  ProductCollectionViewCell.swift
//  MazaadyIOSTask
//
//  Created by Mac on 11/04/2025.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var hoursNumber: UILabel!
    @IBOutlet weak var minutesNumber: UILabel!
    @IBOutlet weak var daysNumber: UILabel!
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
    
    func cellConfigure(product:Product) {
        productImage.layer.cornerRadius = 10
        cellOuterView.layer.cornerRadius = 15
        offerCountDownStack.layer.cornerRadius = 15
       
        productPriceText.text = String(product.price)
        productName.text = product.name
        productPriceOffer.text = String(product.offer ?? 0.0)
        productPriceBeforeOffer.text = String(product.price)
        
        let time = timeComponents(from: product.endDate ?? 0.0)
        daysNumber.text = "\(time.days)"
        hoursNumber.text = "\(time.hours)"
        minutesNumber.text = "\(time.minutes)"

        loadImage(from: product.image, into: productImage)
        offerCountDownStack.isHidden = (product.endDate == nil)
        specialOfferStack.isHidden = (product.offer == nil)

    }
}
