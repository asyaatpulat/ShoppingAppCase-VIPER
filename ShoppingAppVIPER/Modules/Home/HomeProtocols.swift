//
//  HomeProtocols.swift
//
//  Created by Asya Atpulat on 25.10.2023.
//

import Foundation

protocol HomePresenterToHomeInteractorProtocol {
    var presenter: HomeInteractorToHomePresenterProtocol? {get set}
    func fetchFirstListData()
    func fetchSecondListData()
    func fetchThirdListData()
}

protocol HomeViewToHomePresenterProtocol {
    var interactor: HomePresenterToHomeInteractorProtocol? {get set}
    var view: HomePresenterToHomeViewProtocol? {get set}
    
    func fetchFirstListData()
    func fetchSecondListData()
    func fetchThirdListData()
    
}

protocol HomeInteractorToHomePresenterProtocol {
    func firstListDataFetched(response: ListResponse)
    func secondListDataFetched(response: ListResponse)
    func thirdListDataFetched(response: ListResponse)
    func dataFetchFailed(error: Error)
}

protocol HomePresenterToHomeViewProtocol {
    func firstListDataFetched(response: ListResponse)
    func secondListDataFetched(response: ListResponse)
    func thirdListDataFetched(response: ListResponse)
    func dataFetchFailed(error: Error)
}

