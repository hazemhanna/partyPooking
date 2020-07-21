//
//  SearchViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/2/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var partyView: UIView!
    @IBOutlet weak var searchBtn : UIButton!
    @IBOutlet weak var mostFamousLabel: UILabel!
    @IBOutlet weak var offerLabel: UILabel!
    @IBOutlet weak var mostFamousCollection: UICollectionView!
    @IBOutlet weak var offerCollection: UICollectionView!
    @IBOutlet weak var searchTitleLabel: UILabel!
    @IBOutlet weak var locatioLabel: UILabel!
    @IBOutlet weak var partytypeLabel: UILabel!
    
    var notification = false
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MostFamousCollectionViewCell
        cell.layer.cornerRadius = 7
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 30
        let width = (collectionView.bounds.size.width - spacing) / 1.2
        let height = (collectionView.bounds.size.height)
        return CGSize(width: width, height:  height)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        style ()
        // collection view deleget
        mostFamousCollection.delegate = self
        mostFamousCollection.dataSource = self
        mostFamousCollection.register(UINib(nibName: "MostFamousCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        offerCollection.delegate = self
        offerCollection.dataSource = self
        offerCollection.register(UINib(nibName: "MostFamousCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        let location = UITapGestureRecognizer(target: self, action:#selector(SearchViewController.locationTapped(sender:)))
        locationView.addGestureRecognizer(location)
        locationView.isUserInteractionEnabled = true
       setUPLocalize()
        
        if notification{
           print("hazem")
        }else{
           print("lavy")
        }
    }
    
     @objc func locationTapped(sender: UITapGestureRecognizer) {
        let destinationVC = LocationViewController.instantiateFromNib()
        self.navigationController?.pushViewController(destinationVC!, animated: true)
         
     }

    func setUPLocalize(){
        searchBtn.setTitle("searchtitle".localized, for: .normal)
        mostFamousLabel.text = "Most".localized
        offerLabel.text = "Show".localized
        searchTitleLabel.text = "makeSearch".localized
        locatioLabel.text = "location".localized
        partytypeLabel.text = "partyType".localized
        
        if MOLHLanguage.currentAppleLanguage() == "en" {
        let font = UIFont(name: "Georgia-Bold", size: 14)
            searchBtn.titleLabel!.font = UIFont(name: "Georgia-Bold", size: 17)
            offerLabel.font = font
            mostFamousLabel.font = font
            searchTitleLabel.font = UIFont(name: "Georgia-Bold", size: 17)
            locatioLabel.font = font
            partytypeLabel.font = font
        }

     }
     func style (){
        locationView.layer.cornerRadius = 7
        dateView.layer.cornerRadius = 7
        partyView.layer.cornerRadius = 7
        searchBtn.layer.cornerRadius = 7
      }
    
    override func viewWillAppear(_ animated: Bool) {
      self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    
    
    @IBAction func notificationButton(sender: UIButton) {
          let destinationVC = NotificationsViewController.instantiateFromNib()
          self.navigationController?.pushViewController(destinationVC!, animated: true)
      }
    
     @IBAction func searchButton(sender: UIButton) {
        let destinationVC = SearchResultViewController.instantiateFromNib()
        self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
}



