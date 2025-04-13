//
//  ViewController.swift
//  MazaadyIOSTask
//
//  Created by Mac on 11/04/2025.
//

import UIKit

class SplashScreen: UIViewController {


    
    private let logoLabel: UILabel = {
           let label = UILabel()
           label.text = "Mazaady"
           label.font = UIFont.boldSystemFont(ofSize: 36)
           label.textColor = .white
           label.textAlignment = .center
           return label
       }()

       private let welcomeLabel: UILabel = {
           let label = UILabel()
           label.text = "Welcome to Mazaady"
           label.font = UIFont.systemFont(ofSize: 18)
           label.textColor = .white
           label.textAlignment = .center
           label.alpha = 0
           return label
       }()

       override func viewDidLoad() {
           super.viewDidLoad()
           setupGradientBackground()
           setupViews()
           animateSplash()
       }

       private func setupViews() {
           view.addSubview(logoLabel)
           view.addSubview(welcomeLabel)

           logoLabel.translatesAutoresizingMaskIntoConstraints = false
           welcomeLabel.translatesAutoresizingMaskIntoConstraints = false

           NSLayoutConstraint.activate([
               logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               logoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
               
               welcomeLabel.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 12),
               welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
           ])
       }

       private func setupGradientBackground() {
           let gradientLayer = CAGradientLayer()
           gradientLayer.colors = [
                UIColor.systemPink.withAlphaComponent(0.8).cgColor,
                UIColor.labelPink.cgColor
            ]
           gradientLayer.locations = [0.0, 1.0]
           gradientLayer.frame = view.bounds
           view.layer.insertSublayer(gradientLayer, at: 0)
       }

       private func animateSplash() {
           UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseInOut, animations: {
               self.welcomeLabel.alpha = 1.0
           }, completion: { _ in
               DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                   self.showMainApp()
               }
           })
       }

    func showMainApp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tabBarVC = storyboard.instantiateViewController(withIdentifier: "MainTabBar") as? TabBarViewController {
    
            // Set it as the root view controller
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = tabBarVC
    
                // Optional: add transition animation
                UIView.transition(with: sceneDelegate.window!,
                                  duration: 0.5,
                                  options: [.transitionCrossDissolve],
                                  animations: nil,
                                  completion: nil)
            }
        }
    }

}

//override func viewDidLoad() {
//    super.viewDidLoad()
//    
//       DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//               self.showMainApp()
//           }
//    // Do any additional setup after loading the view.
//}
//
//func showMainApp() {
//    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//    if let tabBarVC = storyboard.instantiateViewController(withIdentifier: "MainTabBar") as? TabBarViewController {
//        
//        // Set it as the root view controller
//        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
//            sceneDelegate.window?.rootViewController = tabBarVC
//            
//            // Optional: add transition animation
//            UIView.transition(with: sceneDelegate.window!,
//                              duration: 0.5,
//                              options: [.transitionCrossDissolve],
//                              animations: nil,
//                              completion: nil)
//        }
//    }
//}
