//
//  ArtistWorkVc.swift
//  PartyBooking
//
//  Created by MAC on 21/09/2021.
//  Copyright © 2021 MAC. All rights reserved.
//



import UIKit
import RxSwift
import RxCocoa

class ArtistWorkVc: UIViewController  ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var photoCollection: UICollectionView!
    
    
    let aristId = Helper.getArtistId() ?? 0
    private let profileVM = ArtistProfileViewModel()
    var disposeBag = DisposeBag()
    var work = [ArtistWork]()
    
   private var idintier = "ArtistWorkCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        photoCollection.register(UINib(nibName: idintier, bundle: nil), forCellWithReuseIdentifier: idintier)
        photoCollection.delegate = self
        photoCollection.dataSource = self
        profileVM.showIndicator()
        getWork(artistId : aristId)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    self.navigationController?.navigationBar.isHidden = false
    }
    
  
    
    @IBAction func backButton(sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return work.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idintier, for: indexPath) as! ArtistWorkCell
        
        cell.config(imageURL: work[indexPath.row].url ?? "", videoURL: "")
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
            let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 3.2
            return CGSize(width: size, height: 100)
        }
    
}

extension ArtistWorkVc{
    func getWork(artistId : Int) {
            profileVM.getArtistWork(artistId: artistId).subscribe(onNext: { (data) in
            self.profileVM.dismissIndicator()
            if data.status ?? false {
                self.work = data.result?.data ?? []
                self.photoCollection.reloadData()
            }
        }, onError: { (error) in
            self.profileVM.dismissIndicator()
            displayMessage(title: "", message: "Something went wrong in getting data".localized, status: .error, forController: self)
        }).disposed(by: disposeBag)
     }
}
