//
//  Extensions.swift
//  MazaadyIOSTask
//
//  Created by Mac on 11/04/2025.
//
import UIKit

class RoundedView: UIStackView {
        @IBInspectable var cornerRadius: CGFloat = 0 {
            didSet {
                layer.cornerRadius = cornerRadius
                layer.masksToBounds = cornerRadius > 0
            }
        }
        
        @IBInspectable var borderWidth: CGFloat = 0 {
            didSet {
                layer.borderWidth = borderWidth
            }
        }
        
        @IBInspectable var borderColor: UIColor = .clear {
            didSet {
                layer.borderColor = borderColor.cgColor
            }
        }
    }

extension UIView {
    
    func AddBorderToSearchView()
    {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.tagsBorder.cgColor
    }
}
@IBDesignable
extension UILabel {
    
    // Create a custom IBInspectable property for localization
    @IBInspectable var localizeKey: String? {
        get {
            return self.text
        }
        set {
            if let key = newValue {
                // Set the localized text for the key
                self.text = NSLocalizedString(key, comment: "")
            }
        }
    }
}
@IBDesignable
extension UIButton {
    
    @IBInspectable var localizeKey: String? {
        get {
            return self.title(for: .normal)
        }
        set {
            if let key = newValue {
                // Set the localized title for the key
                self.setTitle(NSLocalizedString(key, comment: ""), for: .normal)
            }
        }
    }
}

extension UIViewController {
    func showLoading() {
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.tag = 999
        loadingIndicator.center = view.center
        loadingIndicator.color = .systemPink
        loadingIndicator.startAnimating()
        view.addSubview(loadingIndicator)
    }

    func hideLoading() {
        if let loadingIndicator = view.viewWithTag(999) as? UIActivityIndicatorView {
            loadingIndicator.stopAnimating()
            loadingIndicator.removeFromSuperview()
        }
    }
}
