//
//  TagsCollectionViewCell.swift
//  MazaadyIOSTask
//
//  Created by Mac on 11/04/2025.
//

import UIKit

class TagsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tagText: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 0.5
        layer.cornerRadius = 9
        layer.borderColor = UIColor.tagsBorder.cgColor

    }
    override var isSelected: Bool {
           didSet {
               updateSelectionStyle()
           }
       }
    func configureCell(with tag:TagModel) {
 
        tagText.text = tag.name
    }
    
    private func updateSelectionStyle() {
          if isSelected {
              
              layer.borderColor = UIColor.systemOrange.cgColor
              tagText.textColor = .systemOrange
              layer.backgroundColor = UIColor.backgroundOrange.cgColor
          } else {
              layer.borderColor = UIColor.tagsBorder.cgColor
              tagText.textColor = .darkGray
              layer.backgroundColor = UIColor.white.cgColor
          }
      }
}
