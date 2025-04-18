//
//  AdsTableViewCell.swift
//  MazaadyIOSTask
//
//  Created by Mac on 11/04/2025.
//

import UIKit

class AdsTableViewCell: UITableViewCell {

    @IBOutlet weak var adImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(with ad: AdsModel) {
        adImage.layer.cornerRadius = 10
        loadImage(from: ad.image, into: adImage)
    }
    
}
