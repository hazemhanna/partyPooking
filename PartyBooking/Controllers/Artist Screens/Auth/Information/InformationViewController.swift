//
//  InformationViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/8/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class InformationViewController: UIViewController {
    
    @IBOutlet weak var nextBtn : UIButton!
    
    @IBOutlet weak var ImportantInfLabel : UILabel!
    @IBOutlet weak var fastLabel : UILabel!
    @IBOutlet weak var yesLabel : UILabel!
    @IBOutlet weak var choosePepoleLabel : UILabel!
    @IBOutlet weak var noLabel : UILabel!
    @IBOutlet weak var timeRecieveingLabel : UILabel!
    @IBOutlet weak var termsLabel : UILabel!
    @IBOutlet weak var yes2Label : UILabel!
    @IBOutlet weak var agreeLabel : UILabel!
    @IBOutlet weak var readLabel : UILabel!
    @IBOutlet weak var ReadyBtn : UIButton!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var succesLabel : UILabel!
    @IBOutlet weak var doneBtn : UIButton!
    @IBOutlet weak var succesView : UIView!

    
    var emailTextField = String()
    var passTextField =  String()
    var lNameTextField =  String()
    var countryTextField =  Int()
    var fNameTextField =  String()
    var phoneTextField =  String()
    var area = Int()
    var serviceTextField =  Int()
    var genderTextField =  String()
    var banckTextField =  String()
    var banckAcountTextField =  String()
    var retrieveMoney = Int()
    var cancelTimeTF = 0
    var image = UIImage()
    
    private let authModel = ArtistAuthenticationVM()
    var disposeBag = DisposeBag()
    
    
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.layer.cornerRadius = 7
        setUPLocalize()
        succesView.isHidden = true
        
    }
    
    
    func setUPLocalize(){
        titleLabel.text = "information".localized
        nextBtn.setTitle("next".localized, for: .normal)
        ReadyBtn.setTitle("Ready".localized, for: .normal)
        ImportantInfLabel.text = "ImportantInf".localized
        fastLabel.text = "fast".localized
        yesLabel.text = "yes".localized
        choosePepoleLabel.text = "choosePepole".localized
        noLabel.text = "no".localized
        timeRecieveingLabel.text = "timeRecieveing".localized
        yes2Label.text = "yes2".localized
        agreeLabel.text = "agree".localized
        readLabel.text = "read".localized
        termsLabel.text = "terms".localized
        succesLabel.text = "investigation".localized
        doneBtn.setTitle("DoneB".localized, for: .normal)

        
        if "lang".localized  == "en" {
            let font = UIFont(name: "Georgia-Bold", size: 14)
            let font2 = UIFont(name: "Georgia-Bold", size: 11)
            titleLabel.font = font
            nextBtn.titleLabel!.font =  UIFont(name: "Georgia-Bold", size: 14)
            ReadyBtn.titleLabel!.font =  UIFont(name: "Georgia-Bold", size: 15)
            ImportantInfLabel.font = font
            fastLabel.font = font2
            yesLabel.font = font2
            choosePepoleLabel.font = font2
            noLabel.font = font2
            timeRecieveingLabel.font = font2
            yes2Label.font = font2
            agreeLabel.font = font2
            readLabel.font = font2
            termsLabel.font = font2
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
    
    @IBAction func nextButton(sender: UIButton) {
        if termsUnchecked{
            if "lang".localized == "ar" {
            displayMessage(title: "", message: "من فضلك وافق علي الشروط والاحكام", status: .error, forController: self)
            }else{
                displayMessage(title: "", message: "please accept terms and condition", status: .error, forController: self)
            }
            return
        }else{
            self.authModel.showIndicator()
            self.register(image: image
                          , countryId: self.countryTextField
                          , bindedEmail: emailTextField
                          , bindedFirstName: fNameTextField
                          , bindedLastName: lNameTextField
                          , bindedPhone: phoneTextField
                          , bindedPassword: passTextField
                          , service_id: serviceTextField
                          , areas: area
                          , bank_name: banckTextField
                          , bank_account: banckAcountTextField
                          , retrieve_money: retrieveMoney
                          , prices: Helper.getPartyPrice() ?? [[:]]
                          , cancel_time: cancelTimeTF
                          , gender: self.genderTextField)
        }

    }
    
    @IBAction func succesButton(sender: UIButton) {
        let main = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Nav")
       if let appDelegate = UIApplication.shared.delegate {
           appDelegate.window??.rootViewController = main
        
       }
    }
    
    
    
    
    var unchecked = true
    @IBAction func tick(sender: UIButton) {
        if unchecked {
            sender.setImage(UIImage(named:"checked.png"), for: .normal)
            unchecked = false
        }
        else {
            sender.setImage( UIImage(named:"unchecked.png"), for: .normal)
            unchecked = true
        }
    }
    
    var termsUnchecked = true
    @IBAction func termsBtn(sender: UIButton) {
        if termsUnchecked {
            sender.setImage(UIImage(named:"checked.png"), for: .normal)
            termsUnchecked = false
        }
        else {
            sender.setImage( UIImage(named:"unchecked.png"), for: .normal)
            termsUnchecked = true
        }
    }
}


extension InformationViewController {
    func register (image : UIImage,countryId:Int,bindedEmail: String, bindedFirstName: String,bindedLastName: String,bindedPhone: String,bindedPassword: String,service_id: Int,areas: Int,bank_name: String,bank_account: String,retrieve_money: Int,prices: [[String : Any]],cancel_time: Int,gender: String) {
        authModel.attemptToRegister(image: image, countryId: countryId, bindedEmail: bindedEmail, bindedFirstName: bindedFirstName, bindedLastName: bindedLastName, bindedPhone: bindedPhone, bindedPassword: bindedPassword, service_id: service_id, areas: areas, bank_name: bank_name, bank_account: bank_account, retrieve_money: retrieve_money, prices: prices, cancel_time: cancel_time, gender: gender).subscribe(onNext: { (data) in
            if data.status ?? false {
                self.authModel.dismissIndicator()
                self.succesView.isHidden = false
                displayMessage(title: "", message: data.message ??  ""  , status: .success, forController: self)
            }else{
                self.authModel.dismissIndicator()
                displayMessage(title: "", message: data.message ??  "" , status: .error, forController: self)
            }
        }, onError: { (error) in
            self.authModel.dismissIndicator()
            displayMessage(title: "", message: error.localizedDescription , status: .error, forController: self)
        }).disposed(by: disposeBag)
     }
}
