//
//  MoreViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/2/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {

    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var version  : UILabel!
    var token = Helper.getAPIToken() ?? ""

    var Items = [SideMenuModel]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ArtistMoreCell", bundle: nil), forCellReuseIdentifier: "ArtistMoreCell")
        tableView.delegate = self
        tableView.dataSource = self
        if token != "" {
            if "lang".localized == "ar" {
                     self.Items = [
                               SideMenuModel(Name: "العروض", Id: "Offers", image: #imageLiteral(resourceName: "1")),
                               SideMenuModel(Name: "المفضلة", Id: "Favourite", image: #imageLiteral(resourceName: "heart (1)")),
                               SideMenuModel(Name: "الدعم الفني", Id: "callCenter", image: #imageLiteral(resourceName: "support")),
                               SideMenuModel(Name: "الاعدادات", Id: "setting", image: #imageLiteral(resourceName: "settings (1)")),
                               SideMenuModel(Name: "حسابي", Id: "account", image: #imageLiteral(resourceName: "5")),
                               SideMenuModel(Name: "من نحن", Id: "about", image: #imageLiteral(resourceName: "5-2")),
                               SideMenuModel(Name: "تسجيل الخروج", Id: "logOut", image: #imageLiteral(resourceName: "5-3")),
                           ]
                }else {
                       self.Items = [
                               SideMenuModel(Name: "Offers", Id: "Offers", image: #imageLiteral(resourceName: "1")),
                               SideMenuModel(Name: "Favourite", Id: "Favourite", image: #imageLiteral(resourceName: "heart (1)")),
                               SideMenuModel(Name: "Call Center", Id: "callCenter", image: #imageLiteral(resourceName: "support")),
                               SideMenuModel(Name: "Setting", Id: "setting", image: #imageLiteral(resourceName: "settings (1)")),
                               SideMenuModel(Name: "Account", Id: "account", image: #imageLiteral(resourceName: "5")),
                               SideMenuModel(Name: "About", Id: "about", image: #imageLiteral(resourceName: "5-2")),
                               SideMenuModel(Name: "logOut", Id: "logOut", image: #imageLiteral(resourceName: "5-3")),
                           ]
            }
        }else{
            if "lang".localized == "ar" {
                     self.Items = [
                               SideMenuModel(Name: "العروض", Id: "Offers", image: #imageLiteral(resourceName: "1")),
                               SideMenuModel(Name: "الاعدادات", Id: "setting", image: #imageLiteral(resourceName: "settings (1)")),
                               SideMenuModel(Name: "من نحن", Id: "about", image: #imageLiteral(resourceName: "5-2")),
                               SideMenuModel(Name: "تسجيل دخول", Id: "Login", image: #imageLiteral(resourceName: "5-3")),
                           ]
                }else {
                       self.Items = [
                               SideMenuModel(Name: "Offers", Id: "Offers", image: #imageLiteral(resourceName: "1")),
                               SideMenuModel(Name: "Setting", Id: "setting", image: #imageLiteral(resourceName: "settings (1)")),
                               SideMenuModel(Name: "About", Id: "about", image: #imageLiteral(resourceName: "5-2")),
                               SideMenuModel(Name: "Login", Id: "Login", image: #imageLiteral(resourceName: "5-3")),
                           ]
            }
        }
   
        
        setUPLocalize()
    }
    
    func selectionAction(index: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            switch self.Items[index].Id ?? "" {
            case "Offers":
                let destinationVC = OffersViewController.instantiateFromNib()
                self.navigationController?.pushViewController(destinationVC!, animated: true)
            case "Favourite":
                let destinationVC = FavouriteViewController.instantiateFromNib()
                self.navigationController?.pushViewController(destinationVC!, animated: true)
                
            case "account":
                let destinationVC = AccountViewController.instantiateFromNib()
                self.navigationController?.pushViewController(destinationVC!, animated: true)
            case "callCenter":
             let destinationVC = CallCenterViewController.instantiateFromNib()
             self.navigationController?.pushViewController(destinationVC!, animated: true)
            case "setting":
                let destinationVC = SettingVc.instantiateFromNib()
             self.navigationController?.pushViewController(destinationVC!, animated: true)
            case "about":
                let main = TermsAndConditionVc.instantiateFromNib()
                 main?.type = "about"
                self.navigationController?.pushViewController(main!, animated: true)

            case "Login"  :
                 let main = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Nav")
                if let appDelegate = UIApplication.shared.delegate {
                    appDelegate.window??.rootViewController = main
                }
            case "logOut":
                let alert = UIAlertController(title: "logOut".localized, message: "Are".localized, preferredStyle: .alert)
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
          titleLabel.text = "more".localized
        if "lang".localized  == "en" {
            let font = UIFont(name: "Georgia-Bold", size: 14)
            titleLabel.font = font
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

extension MoreViewController : UITableViewDelegate , UITableViewDataSource {
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
