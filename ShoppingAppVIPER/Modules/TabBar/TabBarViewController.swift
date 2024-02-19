//
//  TabBarViewController.swift
//
//  Created by Asya Atpulat on 25.10.2023.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Home"
        self.navigationItem.hidesBackButton = true
        self.delegate = self
        self.selectedIndex = 0
    }
    
    @objc func menuButtonAction(sender: UIButton) {
        self.selectedIndex = 0
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let index = tabBarController.viewControllers?.firstIndex(of: viewController) {
            print("Selected tab at index \(index)")
        }
    }
}
