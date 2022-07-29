//
//  ReservationViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/2/20.
//  Copyright © 2020 MAC. All rights reserved.
//



import UIKit
import RxSwift
import RxCocoa

let CellHeight = 80

class ReservationViewController: UIViewController {
    
    @IBOutlet weak var reservationTableView: UITableView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var typeTextField: TextFieldDropDown!
    
    var token = Helper.getAPIToken() ?? ""

    
    private let reservationVM = ReservationViewModel()
    var disposeBag = DisposeBag()
    var currentReservation: [Reservation]=[]
    var endedReservation: [Reservation]=[]
    var cancelReservation: [Reservation]=[]
    
    
    var typeArr: [String]=["current".localized, "ended".localized, "cancelReservation".localized]


    var type = "current"
    override func viewDidLoad() {
        super.viewDidLoad()
        reservationTableView.register(UINib(nibName: "ReservationTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        setUPLocalize()
        setuptypeDropDown()
        typeTextField.text = "current".localized
    }
    
    
    func setuptypeDropDown() {
        typeTextField.optionArray = self.typeArr
        typeTextField.didSelect { (selectedText, index, id) in
            if index == 0 {
                self.type = "current"
            }else if index == 1 {
                self.type = "ended"
            }else {
                self.type = "cancel"
            }
            self.reservationTableView.reloadData()
        }
    }
    
    func setUPLocalize(){
        titleLabel.text = "myReservation".localized
  }
    
    override func viewWillAppear(_ animated: Bool) {
        if token == "" {
            let main = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Nav")
           if let appDelegate = UIApplication.shared.delegate {
               appDelegate.window??.rootViewController = main
           }
        }else{
         reservationVM.showIndicator()
         getReservation()
         self.navigationController?.navigationBar.isHidden = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func backButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ReservationViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == "current"{
            return currentReservation.count
        }else if type == "ended"{
            return endedReservation.count
        }else{
            return cancelReservation.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ReservationTableViewCell
        if type == "current"{
            cell.cancelBtn.isHidden = false
            cell.confirmNumberLabel.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
            cell.NumberLabel.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
            cell.NumberLabel.text = "\(self.currentReservation[indexPath.row].id ?? 0)"
            cell.cancel = {
                let vc = CancelReservationVc.instantiateFromNib()
               vc!.onClickCancel = {
                   self.presentingViewController?.dismiss(animated: true)
               }
                vc?.onClickConfirm = {
                    vc?.firstView.isHidden = true
                    vc?.secondView.isHidden = false
                }
                vc?.onClickDone = {
                    self.presentingViewController?.dismiss(animated: true)
                    self.canceReservation(booking_id: self.currentReservation[indexPath.row].id ?? 0, cancel_reason:  vc?.reasonTF.text ?? "")
                }
               self.present(vc!, animated: true, completion: nil)
           }
        }else if type == "ended"{
            if Helper.getType() == "user" {
            cell.cancelBtn.setTitle("rateArtist".localized, for: .normal)
            cell.cancel = {
                let vc = RateArtistVc.instantiateFromNib()
               vc!.onClickCancel = {
                   self.presentingViewController?.dismiss(animated: true)
               }
              vc?.onClickDone = {
                  self.rateReservation(booking_id:  self.currentReservation[indexPath.row].id ?? 0, comment: vc?.commentTF.text ?? "" , rate: Int(vc?.rate.rating ?? 0) )
                }
               self.present(vc!, animated: true, completion: nil)
             }
            }else{
                cell.cancelBtn.isHidden = true
            }
            cell.confirmNumberLabel.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
            cell.NumberLabel.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
            cell.NumberLabel.text = "\(self.endedReservation[indexPath.row].id ?? 0)"
        }else{
            cell.NumberLabel.text = "\(self.cancelReservation[indexPath.row].id ?? 0)"
            cell.cancelBtn.isHidden = true
            cell.confirmNumberLabel.textColor = #colorLiteral(red: 0.9529411765, green: 0.3137254902, blue: 0.3137254902, alpha: 1)
            cell.NumberLabel.textColor = #colorLiteral(red: 0.9529411765, green: 0.3137254902, blue: 0.3137254902, alpha: 1)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if type == "current"{
            let destinationVC = ReservetionDetailsVc.instantiateFromNib()
            destinationVC?.reservation = currentReservation[indexPath.row]
            self.navigationController?.pushViewController(destinationVC!, animated: true)
        }else if type == "ended"{
            let destinationVC = ReservetionDetailsVc.instantiateFromNib()
            destinationVC!.ended = true
            destinationVC?.reservation = endedReservation[indexPath.row]

            self.navigationController?.pushViewController(destinationVC!, animated: true)
        }else{
            let destinationVC = ReservetionDetailsVc.instantiateFromNib()
            destinationVC!.cancel = true
            destinationVC?.reservation = cancelReservation[indexPath.row]
            self.navigationController?.pushViewController(destinationVC!, animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(CellHeight)
    }
}



extension ReservationViewController {
func getReservation() {
    reservationVM.getReservation().subscribe(onNext: { (data) in
    self.reservationVM.dismissIndicator()
    if data.status ?? false {
        self.currentReservation = data.result?.currentBookings?.data ?? []
        self.endedReservation = data.result?.completedBookings?.data ?? []
        self.cancelReservation = data.result?.cancelledBookings?.data ?? []
        self.reservationTableView.reloadData()
       }
     }, onError: { (error) in
    self.reservationVM.dismissIndicator()
         displayMessage(title: "", message: "Something went wrong in getting data".localized, status: .error, forController: self)
    }).disposed(by: disposeBag)
 }
    
    func canceReservation(booking_id:Int,cancel_reason : String) {
        reservationVM.cancelReservation(booking_id: booking_id, cancel_reason: cancel_reason).subscribe(onNext: { (data) in
        self.reservationVM.dismissIndicator()
        if data.status ?? false {
            self.getReservation()
            self.reservationTableView.reloadData()
        }
    }, onError: { (error) in
        self.reservationVM.dismissIndicator()
    }).disposed(by: disposeBag)
    }

    func rateReservation(booking_id:Int,comment : String, rate : Int) {
        reservationVM.rateReservation(booking_id:booking_id,comment : comment, rate : rate).subscribe(onNext: { (data) in
        self.reservationVM.dismissIndicator()
        if data.status ?? false {
            if "lang".localized == "ar" {
                displayMessage(title: "", message: "تم بنجاح تقييم الفنان", status: .success, forController: self)
            }else{
                displayMessage(title: "", message: "done succesufuly rate artist", status: .success, forController: self)
             }
        }
    }, onError: { (error) in
        self.reservationVM.dismissIndicator()
    }).disposed(by: disposeBag)
    }

    
    
}
