//
//  LoginInteractor.swift
//
//  Created by Asya Atpulat on 24.10.2023.
//

import Foundation

class LoginInteractor: LoginPresenterToLoginInteractorProtocol {
    
    var presenter: LoginInteractorToLoginPresenterProtocol?
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func login(email: String, password: String) {
        networkManager.login(email: email, password: password) { result in
            switch result {
            case .success(let tokenResponse):
                self.presenter?.loginSuccess(token: tokenResponse.token)
            case .failure(let error):
                self.presenter?.loginFailure(error: error)
            }
        }
    }
}
