//
//  HomePresenter.swift
//
//  Created by Asya Atpulat on 25.10.2023.
//

import Foundation

class HomePresenter: HomeViewToHomePresenterProtocol {
    
    var interactor: HomePresenterToHomeInteractorProtocol?
    var view: HomePresenterToHomeViewProtocol?
    
    func fetchFirstListData() {
        interactor?.fetchFirstListData()
    }
    
    func fetchSecondListData() {
        interactor?.fetchSecondListData()
    }
    
    func fetchThirdListData() {
        interactor?.fetchThirdListData()
    }
}

extension HomePresenter: HomeInteractorToHomePresenterProtocol {
    func firstListDataFetched(response: ListResponse) {
        view?.firstListDataFetched(response: response)
    }
    
    func secondListDataFetched(response: ListResponse) {
        view?.secondListDataFetched(response: response)
    }
    
    func thirdListDataFetched(response: ListResponse) {
        view?.thirdListDataFetched(response: response)
    }
    
    func dataFetchFailed(error: Error) {
        view?.dataFetchFailed(error: error)
    }
}
