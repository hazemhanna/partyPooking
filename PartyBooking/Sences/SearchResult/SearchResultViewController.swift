//
//  SearchResultViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/6/20.
//  Copyright © 2020 MAC. All rights reserved.
//


import UIKit

class SearchResultViewController: UIViewController {
    
    @IBOutlet weak var SearchTableView: UITableView!
    @IBOutlet weak var dateImage: UIView!
    @IBOutlet weak var backButton: UIButton! {
           didSet {
               backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
           }
       }
      
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchTableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        dateImage.layer.cornerRadius=7
        dateImage.layer.borderColor=UIColor.white.cgColor
        dateImage.layer.borderWidth=1
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
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

extension SearchResultViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchResultTableViewCell
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
