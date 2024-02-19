//
//  HomeInteractor.swift
//
//  Created by Asya Atpulat on 25.10.2023.
//

import Foundation

class HomeInteractor: HomePresenterToHomeInteractorProtocol {
    
    var presenter: HomeInteractorToHomePresenterProtocol?
    var networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchFirstListData() {
        if let userToken = UserDefaults.standard.string(forKey: "token") {
            networkManager.fetch(.discoverFirstHorizontalList, token: userToken) { [weak self] (result: Result<ListResponse, Error>) in
                switch result {
                case .success(let response):
                    self?.presenter?.firstListDataFetched(response: response)
                case .failure(let error):
                    self?.presenter?.dataFetchFailed(error: error)
                }
            }
        }
    }
    
    func fetchSecondListData() {
        if let userToken = UserDefaults.standard.string(forKey: "token") {
            networkManager.fetch(.discoverSecondHorizontalList, token: userToken) { [weak self] (result: Result<ListResponse, Error>) in
                switch result {
                case .success(let response):
                    self?.presenter?.secondListDataFetched(response: response)
                case .failure(let error):
                    self?.presenter?.dataFetchFailed(error: error)
                }
            }
        }
    }
    
    func fetchThirdListData() {
        if let userToken = UserDefaults.standard.string(forKey: "token") {
            networkManager.fetch(.discoverThirdTwoColumnList, token: userToken) { [weak self] (result: Result<ListResponse, Error>) in
                switch result {
                case .success(let response):
                    self?.presenter?.thirdListDataFetched(response: response)
                case .failure(let error):
                    self?.presenter?.dataFetchFailed(error: error)
                }
            }
        }
    }
}
