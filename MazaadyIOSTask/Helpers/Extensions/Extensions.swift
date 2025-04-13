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
func timeComponents(from seconds: Double) -> (days: Int, hours: Int, minutes: Int) {
    let totalSeconds = Int(seconds)
    let days = totalSeconds / 86400
    let hours = (totalSeconds % 86400) / 3600
    let minutes = (totalSeconds % 3600) / 60
    return (days, hours, minutes)
}
func loadImage(from urlString: String, into imageView: UIImageView) {
    guard let url = URL(string: urlString) else {
        print("Invalid URL string")
        return
    }

    // Check cache first
    if let cachedData = URLCache.shared.cachedResponse(for: URLRequest(url: url))?.data,
       let cachedImage = UIImage(data: cachedData) {
        imageView.image = cachedImage
        return
    }

    // Download image if not in cache
    URLSession.shared.dataTask(with: url) { data, response, error in
        // Handle errors
        if let error = error {
            print("Error loading image: \(error)")
            return
        }

        // Check if data is valid
        guard let data = data, let image = UIImage(data: data) else {
            print("Invalid image data")
            return
        }

        // Save to cache
        if let response = response {
            let cachedResponse = CachedURLResponse(response: response, data: data)
            URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
        }

        // Update the UI on the main thread
        DispatchQueue.main.async {
            imageView.image = image
        }
    }.resume()
}
