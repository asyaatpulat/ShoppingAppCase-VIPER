//
//  HomeViewController.swift
//
//  Created by Asya Atpulat on 25.10.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var firstListCollectionView: UICollectionView!
    @IBOutlet weak var secondListCollectionView: UICollectionView!
    @IBOutlet weak var thirdListCollectionView: UICollectionView!
    
    var presenter: HomeViewToHomePresenterProtocol?
    
    var firstListResponse: ListResponse?
    var secondListResponse: ListResponse?
    var thirdListResponse: ListResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        thirdListCollectionView.register(UINib(nibName: "DiscountedThirdListCell", bundle: nil), forCellWithReuseIdentifier: "DiscountedThirdListCell")
        presenter?.fetchFirstListData()
        presenter?.fetchSecondListData()
        presenter?.fetchThirdListData()
    }
    
    func prepareCollectionView() {
        firstListCollectionView?.delegate = self
        firstListCollectionView?.dataSource = self
        
        secondListCollectionView?.dataSource = self
        secondListCollectionView?.delegate = self
        
        thirdListCollectionView?.delegate = self
        thirdListCollectionView?.dataSource = self
    }
    
    func reloadFirstCollectionView() {
        DispatchQueue.main.async {
            self.firstListCollectionView?.reloadData()
        }
    }
    
    func reloadSecondCollectionView() {
        DispatchQueue.main.async {
            self.secondListCollectionView?.reloadData()
        }
    }
    
    func reloadThirdCollectionView() {
        DispatchQueue.main.async {
            self.thirdListCollectionView?.reloadData()
        }
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Coming Soon", message: "This feature is coming soon!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension HomeViewController: HomePresenterToHomeViewProtocol {
    func firstListDataFetched(response: ListResponse) {
        firstListResponse = response
        reloadFirstCollectionView()
    }
    
    func secondListDataFetched(response: ListResponse) {
        secondListResponse = response
        reloadSecondCollectionView()
    }
    
    func thirdListDataFetched(response: ListResponse) {
        thirdListResponse = response
        reloadThirdCollectionView()
    }
    
    func dataFetchFailed(error: Error) {
        print("data fetch failed.")
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == firstListCollectionView {
            return firstListResponse?.list?.count ?? 0
        } else if collectionView == secondListCollectionView {
            return secondListResponse?.list?.count ?? 0
        } else if collectionView == thirdListCollectionView {
            return thirdListResponse?.list?.count ?? 0
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.firstListCollectionView {
            let list = firstListResponse?.list?[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirstListCell.identifier, for: indexPath) as? FirstListCell else {
                fatalError("DequeueReusableCell failed while casting")
            }
            cell.configure(with: list!)
            return cell
        } else if collectionView == self.secondListCollectionView {
            let list = secondListResponse?.list?[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondListCell.identifier, for: indexPath) as? SecondListCell else {
                fatalError("DequeueReusableCell failed while casting")
            }
            cell.configure(with: list!)
            return cell
        } else if collectionView == self.thirdListCollectionView {
            let list = thirdListResponse?.list?[indexPath.row]
            if let discount = list?.discount, discount.isEmpty == false {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscountedThirdListCell", for: indexPath) as? DiscountedThirdListCell else {
                    fatalError("DequeueReusableCell failed while casting")
                }
                cell.configure(with: list!)
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThirdListCell.identifier, for: indexPath) as? ThirdListCell else {
                    fatalError("DequeueReusableCell failed while casting")
                }
                cell.configure(with: list!)
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.firstListCollectionView {
            return CGSize(width: (collectionView.bounds.width - 20) / 2, height: 248)
        } else if collectionView == self.secondListCollectionView {
            return CGSize(width: (collectionView.bounds.width - 24) / 3, height: 180)
        } else if collectionView == self.thirdListCollectionView {
            let list = thirdListResponse?.list?[indexPath.row]
            if let discount = list?.discount, !discount.isEmpty {
                let itemWidth = (collectionView.bounds.width - 20) / 2
                return CGSize(width: itemWidth, height: 248)
            } else {
                let itemWidth = (collectionView.bounds.width - 20) / 2
                return CGSize(width: itemWidth, height: 328)
            }
        } else {
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 8, bottom: 16, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.firstListCollectionView {
            return 4
        } else if collectionView == self.secondListCollectionView {
            return 4
        } else if collectionView == self.thirdListCollectionView {
            return 16
        } else {
            return CGFloat()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.firstListCollectionView {
            return 16
        } else if collectionView == self.secondListCollectionView {
            return 16
        } else if collectionView == self.thirdListCollectionView {
            return 4
        } else {
            return CGFloat()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.firstListCollectionView {
            AnalyticsManager.shared.log(.cellSelected(CellSelectedEvent(cellTitle: firstListResponse?.list?[indexPath.row].description ?? "Unknown Title")))
            showAlert()
        } else if collectionView == self.secondListCollectionView {
            AnalyticsManager.shared.log(.cellSelected(CellSelectedEvent(cellTitle: secondListResponse?.list?[indexPath.row].description ?? "Unknown Title")))
            showAlert()
        } else if collectionView == self.thirdListCollectionView {
            AnalyticsManager.shared.log(.cellSelected(CellSelectedEvent(cellTitle: thirdListResponse?.list?[indexPath.row].description ?? "Unknown Title")))
            showAlert()
        }
    }
}
