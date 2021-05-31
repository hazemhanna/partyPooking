//
//  ArtistMoreViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/9/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class ArtistMoreViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var titleLabel  : UILabel!
    @IBOutlet weak var version  : UILabel!
    
    
    var Items = [SideMenuModel]() {
        didSet {
            DispatchQueue.main.async {
                //self.ProfileVM.fetchItems(data: self.Items)
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ArtistMoreCell", bundle: nil), forCellReuseIdentifier: "ArtistMoreCell")
        tableView.delegate = self
        tableView.dataSource = self
        setUPLocalize()
        
            if "lang".localized == "ar" {
                     self.Items = [
                               SideMenuModel(Name: "الفواتير", Id: "bills", image: #imageLiteral(resourceName: "1")),
                               SideMenuModel(Name: "تجربة المستخدمين", Id: "exprience", image: #imageLiteral(resourceName: "3")),
                               SideMenuModel(Name: "الدعم الفني", Id: "callCenter", image: #imageLiteral(resourceName: "support")),
                               SideMenuModel(Name: "وضع عدم الازعاج", Id: "silent", image: #imageLiteral(resourceName: "4")),
                               SideMenuModel(Name: "الاعدادات", Id: "setting", image: #imageLiteral(resourceName: "settings (1)")),
                               SideMenuModel(Name: "الاشعارات", Id: "notification", image: #imageLiteral(resourceName: "5-1")),
                               SideMenuModel(Name: "حسابي", Id: "account", image: #imageLiteral(resourceName: "5")),
                               SideMenuModel(Name: "من نحن", Id: "about", image: #imageLiteral(resourceName: "5-2")),
                               SideMenuModel(Name: "تسجيل الخروج", Id: "logOut", image: #imageLiteral(resourceName: "5-3")),
                           ]
                }else {
                       self.Items = [
                               SideMenuModel(Name: "Bills", Id: "bills", image: #imageLiteral(resourceName: "1")),
                               SideMenuModel(Name: "User Exprience", Id: "exprience", image: #imageLiteral(resourceName: "3")),
                               SideMenuModel(Name: "Call Center", Id: "callCenter", image: #imageLiteral(resourceName: "support")),
                               SideMenuModel(Name: "Silent", Id: "silent", image: #imageLiteral(resourceName: "4")),
                               SideMenuModel(Name: "Setting", Id: "setting", image: #imageLiteral(resourceName: "settings (1)")),
                               SideMenuModel(Name: "Notification", Id: "notification", image: #imageLiteral(resourceName: "5-1")),
                               SideMenuModel(Name: "Account", Id: "account", image: #imageLiteral(resourceName: "5")),
                               SideMenuModel(Name: "About", Id: "about", image: #imageLiteral(resourceName: "5-2")),
                               SideMenuModel(Name: "logOut", Id: "logOut", image: #imageLiteral(resourceName: "5-3")),
                           ]
            }
    }
    
       func selectionAction(index: Int) {
           DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
               switch self.Items[index].Id ?? "" {
               case "bills":
                let destinationVC = ReservationViewController.instantiateFromNib()
                self.navigationController?.pushViewController(destinationVC!, animated: true)
               case "exprience":
                let destinationVC = RateViewController.instantiateFromNib()
                self.navigationController?.pushViewController(destinationVC!, animated: true)
                
               case "notification":
                   print("notification")
               case "callCenter":
                let destinationVC = CallCenterViewController.instantiateFromNib()
                self.navigationController?.pushViewController(destinationVC!, animated: true)
                
               case "silent":
                let destinationVC = SilentViewController.instantiateFromNib()
                self.navigationController?.pushViewController(destinationVC!, animated: true)
               case "setting":
                let destinationVC = SettingVc.instantiateFromNib()
                self.navigationController?.pushViewController(destinationVC!, animated: true)
               case "about":
                print("about")

               case "logOut":
                   let alert = UIAlertController(title: "LogOut".localized, message: "Are".localized, preferredStyle: .alert)
                   let yesAction = UIAlertAction(title: "YES".localized, style: .default) { (action) in
                       alert.dismiss(animated: true, completion: nil)
                       Helper.LogOut()
                       guard let main = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChooseUSerTypeVC") as? ChooseUSerTypeVC else { return }
                       self.navigationController?.pushViewController(main, animated: true)
                       
                   }
                   yesAction.setValue(#colorLiteral(red: 0.3104775548, green: 0.3218831122, blue: 0.4838557839, alpha: 1), forKey: "titleTextColor")
                   let cancelAction = UIAlertAction(title: "NO".localized, style: .cancel, handler: nil)
                   cancelAction.setValue(#colorLiteral(red: 0.3104775548, green: 0.3218831122, blue: 0.4838557839, alpha: 1), forKey: "titleTextColor")
                   alert.addAction(yesAction)
                   alert.addAction(cancelAction)
                   self.present(alert, animated: true, completion: nil)

               default:
                   break
               }
           }
       }
    
    func setUPLocalize(){
        version.text = "\("version".localized) - 2.2.1"
        titleLabel.text = "more".localized
        if MOLHLanguage.currentAppleLanguage() == "en" {
            let font = UIFont(name: "Georgia-Bold", size: 14)
            titleLabel.font = font
            version.font = font
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
    
}

extension ArtistMoreViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistMoreCell", for: indexPath) as! ArtistMoreCell
        cell.config(Name: Items[indexPath.row].Name , image: Items[indexPath.row].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectionAction(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
    
}
