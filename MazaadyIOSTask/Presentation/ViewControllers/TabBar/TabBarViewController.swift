//
//  TabBarViewController.swift
//  MazaadyIOSTask
//
//  Created by Mac on 12/04/2025.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    let centerButton = UIButton(type: .custom)

    override func viewDidLoad() {
        super.viewDidLoad()

    }

      override func loadView() {
          super.loadView()
          addOffsetToBarItem()
          addMiddleTabBarButton()
          self.selectedIndex = 3
      }
      
    
    func addOffsetToBarItem()
    {
        self.tabBar.items?.forEach { (item) in
            item.title = NSLocalizedString(item.title ?? "", comment: "")
            if item.tag == 1 {
                item.titlePositionAdjustment =  (L102Language.currentAppleLanguage() == "en") ? UIOffset(horizontal: -10, vertical: 0) : UIOffset(horizontal: 20, vertical: 0)
                
            }
            if item.tag == 2 {
                item.titlePositionAdjustment =  (L102Language.currentAppleLanguage() == "en") ? UIOffset(horizontal: 10, vertical: 0) : UIOffset(horizontal: -20, vertical: 0)
                
            }
        }
    }
    
    func addShadowToMiddleButton()
    {
        centerButton.layer.shadowColor = UIColor.systemPink.cgColor
        centerButton.layer.shadowOpacity = 0.25
        centerButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        centerButton.layer.shadowRadius = 6
        centerButton.layer.masksToBounds = false
    }
    
    func addMiddleTabBarButton()
    {
        centerButton.setImage(UIImage(named:"ShopTabBarIcon"), for: .normal)
        centerButton.tintColor = UIColor.labelPink
        centerButton.backgroundColor = UIColor.labelPink
        centerButton.layer.cornerRadius = 10
        centerButton.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        centerButton.center = CGPoint(x: self.tabBar.center.x, y: self.view.bounds.height - 50) // Adjust as needed
        addShadowToMiddleButton()
        
        self.view.addSubview(centerButton)
        self.view.bringSubviewToFront(centerButton)
        
    }
    
 
}


