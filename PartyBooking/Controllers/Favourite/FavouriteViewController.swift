//
//  FavouriteViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/4/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FavouriteViewController: UIViewController {
    
    @IBOutlet weak var favouriteTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
        }
    }
    
    private let favouriteVM = FavouriteViewModel()
    var disposeBag = DisposeBag()
    
    var favourite = [Favourite]()

    override func viewDidLoad() {
        super.viewDidLoad()
        favouriteTableView.register(UINib(nibName: "FavouriteTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        setUPLocalize()
      
    }
    
    func setUPLocalize(){
        titleLabel.text = "favourite".localized
     }
    
    override func viewWillAppear(_ animated: Bool) {
        favouriteVM.showIndicator()
        getFavourite()
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func backButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension FavouriteViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourite.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FavouriteTableViewCell
        
        cell.confic(imageUrl:  self.favourite[indexPath.row].artist?.image ?? "", name: ((self.favourite[indexPath.row].artist?.firstName ?? "") + " " + (self.favourite[indexPath.row].artist?.lastName ?? "")), locaction: (self.favourite[indexPath.row].artist?.address ?? ""), rate: (self.favourite[indexPath.row].artist?.rate ?? 0))
        cell.Favourite = {
            self.favouriteVM.showIndicator()
            self.addFavourite(artistId: (self.favourite[indexPath.row].id ?? 0))
        }
        
        cell.viewProfile = {
            let destinationVC = ArtistProfileViewController.instantiateFromNib()
            self.navigationController?.pushViewController(destinationVC!, animated: true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(150)
    }
    
}


extension FavouriteViewController {
    
func getFavourite() {
    favouriteVM.getFavourite().subscribe(onNext: { (data) in
        self.favouriteVM.dismissIndicator()
        if data.status ?? false {
            self.favourite = data.result?.data ?? []
            self.favouriteTableView.reloadData()
        }
    }, onError: { (error) in
        self.favouriteVM.dismissIndicator()
        displayMessage(title: "", message: "Something went wrong in getting data", status: .error, forController: self)
    }).disposed(by: disposeBag)
 }
    
   
    func addFavourite(artistId : Int ) {
        favouriteVM.addFavourite(artistId: artistId).subscribe(onNext: { (data) in
            self.favouriteVM.dismissIndicator()
            if data.status ?? false {
                self.getFavourite()
                displayMessage(title: "", message: data.message ?? "", status: .success, forController: self)
            }
        }, onError: { (error) in
            self.favouriteVM.dismissIndicator()
            displayMessage(title: "", message: "Something went wrong in getting data", status: .error, forController: self)
        }).disposed(by: disposeBag)
     }
      
    
    
}
