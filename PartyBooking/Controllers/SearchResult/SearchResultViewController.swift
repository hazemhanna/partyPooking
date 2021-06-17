//
//  SearchResultViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/6/20.
//  Copyright © 2020 MAC. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa

class SearchResultViewController: UIViewController {
    
    var filterdArtist = [Artists]()
    private let searchVM = SearchResultViewModel()
    
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var SearchTableView: UITableView!
    @IBOutlet weak var backButton: UIButton! {
           didSet {
               backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
           }
       }
      
    var areaId =  Int()
    var typeId = Int()
    var date = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchTableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
   override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
         searchVM.showIndicator()
     }
    
    override func viewDidAppear(_ animated: Bool) {
        self.getsearchResult(area: areaId, date: date, type:typeId )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            self.navigationController?.navigationBar.isHidden = false
            self.tabBarController?.tabBar.isHidden = false
        }
  
    @IBAction func backButton(sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
        }

    
}

extension SearchResultViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterdArtist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchResultTableViewCell
        cell.confic(imageUrl:  self.filterdArtist[indexPath.row].image ?? "", name: ((self.filterdArtist[indexPath.row].firstName ?? "") + " " + (self.filterdArtist[indexPath.row].lastName ?? "")), locaction: (self.filterdArtist[indexPath.row].address ?? ""), rate: (self.filterdArtist[indexPath.row].rate ?? 0),price : 89,isFavourite :self.filterdArtist[indexPath.row].favourite ?? 0)
        cell.addFavourite = {
            self.searchVM.showIndicator()
            self.addFavourite(artistId: (self.filterdArtist[indexPath.row].id ?? 0))
        }
        
            return cell
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = ArtistProfileViewController.instantiateFromNib()
        self.navigationController?.pushViewController(destinationVC!, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return CGFloat(150)
        
    }
}


extension SearchResultViewController {
    
func getsearchResult(area : Int , date : String , type : Int) {
    searchVM.getSearchResult(area: area, date: date, type: type).subscribe(onNext: { (data) in
        self.searchVM.dismissIndicator()
        if data.status ?? false {
            self.filterdArtist = data.result ?? []
            self.SearchTableView.reloadData()
        }
    }, onError: { (error) in
        self.searchVM.dismissIndicator()
        displayMessage(title: "", message: "Something went wrong in getting data", status: .error, forController: self)
    }).disposed(by: disposeBag)
 }
    
   
    func addFavourite(artistId : Int ) {
        searchVM.addFavourite(artistId: artistId).subscribe(onNext: { (data) in
            self.searchVM.dismissIndicator()
            if data.status ?? false {
                displayMessage(title: "", message: data.message ?? "", status: .success, forController: self)
                self.getsearchResult(area: self.areaId, date: self.date, type:self.typeId )
            }
        }, onError: { (error) in
            self.searchVM.dismissIndicator()
            displayMessage(title: "", message: "Something went wrong in getting data", status: .error, forController: self)
        }).disposed(by: disposeBag)
     }
      
    
    
}
