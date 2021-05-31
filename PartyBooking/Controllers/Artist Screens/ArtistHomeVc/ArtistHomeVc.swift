//
//  ArtistHomeVc.swift
//  PartyBooking
//
//  Created by MAC on 23/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//


import UIKit

class ArtistHomeVc: UIViewController  ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var photoCollection: UICollectionView!
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var profileView : UIView!
    @IBOutlet weak var profilePicLabel : UILabel!
    @IBOutlet weak var aboutMeLabel : UILabel!
    @IBOutlet weak var myWorkLabel : UILabel!
    @IBOutlet weak var liveLabel : UILabel!
    @IBOutlet weak var titleLabel : UILabel!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCollectionViewCell
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 20
        let width = (collectionView.bounds.size.width - spacing) / 3
        let height = (collectionView.bounds.size.height)
        return CGSize(width: width, height:  height)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoCollection.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        profileView.layer.cornerRadius = profileView.frame.width / 2
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        setUPLocalize()
    }
    
    
    func setUPLocalize(){
        titleLabel.text = "information".localized
        profilePicLabel.text = "profilePic".localized
        aboutMeLabel.text = "aboutMe".localized
        myWorkLabel.text = "myWork".localized
        liveLabel.text = "live".localized
        if MOLHLanguage.currentAppleLanguage() == "en" {
            let font = UIFont(name: "Georgia-Bold", size: 14)
            titleLabel.font = font
            profilePicLabel.font = font
            aboutMeLabel.font = font
            myWorkLabel.font = font
            liveLabel.font = font
        }
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
    
    @IBAction func liveButton(sender: UIButton) {
    let destinationVC = LiveVideoViewController.instantiateFromNib()
    self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
}
