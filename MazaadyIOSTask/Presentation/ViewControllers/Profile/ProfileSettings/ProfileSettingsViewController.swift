//
//  ProfileSettingsViewController.swift
//  MazaadyIOSTask
//
//  Created by Mac on 12/04/2025.
//

import UIKit

class ProfileSettingsViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var arabicButton: RadioButton!
    @IBOutlet weak var englishButton: RadioButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.placeholder = NSLocalizedString("Search", comment: "")
        self.searchBarView.AddBorderToSearchView()
       if  L102Language.currentAppleLanguage() == "en"
        {
           englishButton.isSelected = true
       }
        else
        {
            arabicButton.isSelected = true
        }
    }
    
    
    @IBAction func changeLanguageAction(_ sender: UIButton) {
        
        englishButton.isSelected = sender == englishButton
        arabicButton.isSelected = sender == arabicButton
        
        let languageCode = sender == englishButton ? "en" : "ar"
        localize()
    }
    func localize()  {
        if L102Language.currentAppleLanguage() == "en" {
            
            L102Language.setAppleLAnguageTo(lang: "ar")
            UILabel.appearance().semanticContentAttribute = .forceRightToLeft
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UIButton.appearance().semanticContentAttribute = .forceRightToLeft
            UIStackView.appearance().semanticContentAttribute = .forceRightToLeft
            
        }
        else{
            L102Language.setAppleLAnguageTo(lang: "en")
            UILabel.appearance().semanticContentAttribute = .forceLeftToRight
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UIButton.appearance().semanticContentAttribute = .forceLeftToRight
            UIStackView.appearance().semanticContentAttribute = .forceLeftToRight
            
        }
        L102Localizer.cstmlayoutSubviews()
        reloadRootViewController()
    }
    func reloadRootViewController() {
           // Force the app to restart or reinitialize the root view controller
           if let window = UIApplication.shared.windows.first {
               window.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
               window.makeKeyAndVisible()
           }
       }

    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
}

