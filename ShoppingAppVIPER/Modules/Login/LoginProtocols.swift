//
//  LoginProtocols.swift
//
//  Created by Asya Atpulat on 24.10.2023.
//

import Foundation

protocol LoginPresenterToLoginInteractorProtocol {
    var presenter: LoginInteractorToLoginPresenterProtocol? {get set}
    
    func login(email: String, password: String)
}

protocol LoginViewToLoginPresenterProtocol {
    var interactor: LoginPresenterToLoginInteractorProtocol? {get set}
    var view: LoginPresenterToLoginViewProtocol? {get set}
    
    func loginTapped(email: String, password: String)
}

protocol LoginInteractorToLoginPresenterProtocol {
    func loginSuccess(token: String)
    func loginFailure(error: Error)
}

protocol LoginPresenterToLoginViewProtocol {
    func loginSuccess()
    func loginFailure(error: Error)
}
