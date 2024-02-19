//
//  TabBarRouter.swift
//
//  Created by Asya Atpulat on 26.10.2023.
//

import Foundation
import UIKit

class TabBarRouter {
    private weak var view: UIViewController?
    
    init(view: UIViewController? = nil) {
        self.view = view
    }
    
    static func createModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController else {
            fatalError("DequeueReusableCell failed while casting")
        }
        guard let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else {
            fatalError("DequeueReusableCell failed while casting")
        }
        let presenter = HomePresenter()
        let networkManager = NetworkManager()
        let interactor = HomeInteractor(networkManager: networkManager)
        homeViewController.presenter = presenter
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.view = homeViewController
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
        let thirdViewController = storyboard.instantiateViewController(withIdentifier: "ThirdViewController")
        let fourthViewController = storyboard.instantiateViewController(withIdentifier: "FourthViewController")
        let fifthViewController = storyboard.instantiateViewController(withIdentifier: "FifthViewController")
        tabBarController.viewControllers = [homeViewController, secondViewController, thirdViewController, fourthViewController, fifthViewController]
        return tabBarController
    }
}
