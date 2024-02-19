//
//  LoginRouter.swift
//
//  Created by Asya Atpulat on 24.10.2023.
//

import Foundation
import UIKit

class LoginRouter {
    private weak var view: UIViewController?
    
    init(view: UIViewController? = nil) {
        self.view = view
    }
    
    static func createModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
            fatalError("DequeueReusableCell failed while casting")
        }
        let presenter = LoginPresenter()
        let networkManager = NetworkManager()
        let router = LoginRouter(view: loginViewController)
        let interactor = LoginInteractor(networkManager: networkManager)
        loginViewController.presenter = presenter
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.view = loginViewController
        loginViewController.router = router
        return loginViewController
    }
    
    func toHome() {
        DispatchQueue.main.async {
            let tabBarController = TabBarRouter.createModule()
            self.view?.navigationController?.pushViewController(tabBarController, animated: true)
        }
    }
}
