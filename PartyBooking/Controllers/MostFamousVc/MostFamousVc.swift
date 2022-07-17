//
//  MostFamousVc.swift
//  PartyBooking
//
//  Created by MAC on 15/06/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MostFamousVc: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mostFamousCollection: UICollectionView!
    
    var best = [Artists]()

    private let homeVM = HomeViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mostFamousCollection.delegate = self
        mostFamousCollection.dataSource = self
        mostFamousCollection.register(UINib(nibName: "MostFamousCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        titleLabel.text = "Most".localized
        self.homeVM.showIndicator()
        getBest()
      
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.best.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MostFamousCollectionViewCell
        cell.locationImage.isHidden = false
        cell.titleLbl.isHidden = false
        cell.locationLbl.isHidden = false
        cell.confic(imageUrl: self.best[indexPath.row].image ?? "", name: ((self.best[indexPath.row].firstName ?? "") + " " + (self.best[indexPath.row].lastName ?? "")), locaction: (self.best[indexPath.row].country?.arName ?? ""))
        cell.layer.cornerRadius = 7
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destinationVC = ArtistProfileViewController.instantiateFromNib()
        destinationVC!.artistId = best[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (collectionView.bounds.size.width)
        return CGSize(width: width, height:  150)
    }
    
    override func viewWillAppear(_ animated: Bool) {
      self.navigationController?.navigationBar.isHidden = true
    }
     
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func backBtn(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
      }

}

extension MostFamousVc {

func getBest() {
    homeVM.getBestArtist().subscribe(onNext: { (data) in
        if data.status ?? false {
            self.homeVM.dismissIndicator()
            self.best = data.result?.data ?? []
            self.mostFamousCollection.reloadData()
        }
    }, onError: { (error) in
        self.homeVM.dismissIndicator()
        displayMessage(title: "", message: "Something went wrong in getting data".localized, status: .error, forController: self)
    }).disposed(by: disposeBag)
 }
    
}
