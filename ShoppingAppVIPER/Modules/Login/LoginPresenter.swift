//
//  Presenter.swift
//
//  Created by Asya Atpulat on 24.10.2023.
//

import Foundation
import UIKit

class LoginPresenter: LoginViewToLoginPresenterProtocol {
    
    var interactor: LoginPresenterToLoginInteractorProtocol?
    var view: LoginPresenterToLoginViewProtocol?
    
    func loginTapped(email: String, password: String) {
        interactor?.login(email: email, password: password)
    }
}

extension LoginPresenter: LoginInteractorToLoginPresenterProtocol {
    func loginSuccess(token: String) {
        view?.loginSuccess()
        UserDefaults.standard.set(token, forKey: "token")
    }
    
    func loginFailure(error: Error) {
        view?.loginFailure(error: error)
    }
}
