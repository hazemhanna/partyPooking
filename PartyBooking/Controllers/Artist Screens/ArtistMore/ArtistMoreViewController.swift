//
//  ArtistMoreViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/9/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ArtistMoreViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var titleLabel  : UILabel!
    var token = Helper.getAPIToken() ?? ""
    var partPice = [PartPice]()
    private let profileVM = ArtistProfileViewModel()
    var disposeBag = DisposeBag()
    
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
        setUPLocalize()
        if token != "" {
            if "lang".localized == "ar" {
                     self.Items = [
                               SideMenuModel(Name: "اعدادات تواريخ الحجوزات", Id: "bills", image: #imageLiteral(resourceName: "1")),
                               SideMenuModel(Name: "تجربة المستخدمين", Id: "exprience", image: #imageLiteral(resourceName: "3")),
                               SideMenuModel(Name: "وضع عدم الازعاج", Id: "silent", image: #imageLiteral(resourceName: "4")),
                               SideMenuModel(Name: "اسعار الحفلات", Id: "partyPrice", image: #imageLiteral(resourceName: "1")),
                               SideMenuModel(Name: "الاعدادات", Id: "setting", image: #imageLiteral(resourceName: "settings (1)")),
                               SideMenuModel(Name: "الدعم الفني", Id: "callCenter", image: #imageLiteral(resourceName: "support")),
                               SideMenuModel(Name: "من نحن", Id: "about", image: #imageLiteral(resourceName: "5-2")),
                               SideMenuModel(Name: "الشروط والاحكام", Id: "terms", image: #imageLiteral(resourceName: "5-2")),
                              SideMenuModel(Name: "الخصوصية", Id: "privacy", image: #imageLiteral(resourceName: "5-2")),
                               SideMenuModel(Name: "تسجيل الخروج", Id: "logOut", image: #imageLiteral(resourceName: "5-3")),
                           ]
                }else {
                       self.Items = [
                               SideMenuModel(Name: "setting reservation dates", Id: "bills", image: #imageLiteral(resourceName: "1")),
                               SideMenuModel(Name: "User Exprience", Id: "exprience", image: #imageLiteral(resourceName: "3")),
                               SideMenuModel(Name: "Silent", Id: "silent", image: #imageLiteral(resourceName: "4")),
                               SideMenuModel(Name: "party Prices", Id: "partyPrice", image: #imageLiteral(resourceName: "1")),
                               SideMenuModel(Name: "Call Center", Id: "callCenter", image: #imageLiteral(resourceName: "support")),
                               SideMenuModel(Name: "Setting", Id: "setting", image: #imageLiteral(resourceName: "settings (1)")),
                               SideMenuModel(Name: "About", Id: "about", image: #imageLiteral(resourceName: "5-2")),
                               SideMenuModel(Name: "Terms & conditions", Id: "terms", image: #imageLiteral(resourceName: "5-2")),
                               SideMenuModel(Name: "privacy", Id: "privacy", image: #imageLiteral(resourceName: "5-2")),
                               SideMenuModel(Name: "logOut", Id: "logOut", image: #imageLiteral(resourceName: "5-3")),
                           ]
            }
        }else{
            if "lang".localized == "ar" {
                     self.Items = [
                               SideMenuModel(Name: "العروض", Id: "Offers", image: #imageLiteral(resourceName: "1")),
                               SideMenuModel(Name: "الاعدادات", Id: "setting", image: #imageLiteral(resourceName: "settings (1)")),
                               SideMenuModel(Name: "من نحن", Id: "about", image: #imageLiteral(resourceName: "5-2")),
                               SideMenuModel(Name: "الشروط والاحكام", Id: "terms", image: #imageLiteral(resourceName: "5-2")),
                              SideMenuModel(Name: "الخصوصية", Id: "privacy", image: #imageLiteral(resourceName: "5-2")),
                               SideMenuModel(Name: "تسجيل دخول", Id: "Login", image: #imageLiteral(resourceName: "5-3")),
                           ]
                }else {
                       self.Items = [
                               SideMenuModel(Name: "Offers", Id: "Offers", image: #imageLiteral(resourceName: "1")),
                               SideMenuModel(Name: "Setting", Id: "setting", image: #imageLiteral(resourceName: "settings (1)")),
                               SideMenuModel(Name: "About", Id: "about", image: #imageLiteral(resourceName: "5-2")),
                               SideMenuModel(Name: "Terms & conditions", Id: "terms", image: #imageLiteral(resourceName: "5-2")),
                               SideMenuModel(Name: "privacy", Id: "privacy", image: #imageLiteral(resourceName: "5-2")),
                               SideMenuModel(Name: "Login", Id: "Login", image: #imageLiteral(resourceName: "5-3")),
                           ]
            }
        }
    }
    
    
    
       func selectionAction(index: Int) {
           DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
               switch self.Items[index].Id {
               case "bills":
                let destinationVC = AvailableReservationViewController.instantiateFromNib()
                self.navigationController?.pushViewController(destinationVC!, animated: true)
               case "exprience":
                let destinationVC = RateViewController.instantiateFromNib()
                self.navigationController?.pushViewController(destinationVC!, animated: true)
               case "notification":
                   print("notification")
               case "partyPrice":
               let destinationVC = UpdatePricesVC.instantiateFromNib()
                destinationVC?.partPice = self.partPice
                self.navigationController?.pushViewController(destinationVC!, animated: true)
                   
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
                let main = TermsAndConditionVc.instantiateFromNib()
                 main?.type = "about"
                self.navigationController?.pushViewController(main!, animated: true)
               case "terms":
                   let main = TermsAndConditionVc.instantiateFromNib()
                    main?.type = "terms"
                   self.navigationController?.pushViewController(main!, animated: true)
               case "privacy":
               let main = TermsAndConditionVc.instantiateFromNib()
               main?.type = "privacy"
               self.navigationController?.pushViewController(main!, animated: true)
               case "Login"  :
                    let main = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Nav")
                   if let appDelegate = UIApplication.shared.delegate {
                       appDelegate.window??.rootViewController = main
               }
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
        titleLabel.text = "more".localized
        if "lang".localized  == "en" {
            let font = UIFont(name: "Georgia-Bold", size: 14)
            titleLabel.font = font
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if token != "" {
            getProfile()
        }
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func backButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getProfile() {
        profileVM.getProfile().subscribe(onNext: { (data) in
        self.profileVM.dismissIndicator()
        if data.status ?? false {
            self.partPice = data.result?.artist?.partPices ?? []
        }
    }, onError: { (error) in
        self.profileVM.dismissIndicator()

    }).disposed(by: disposeBag)
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
