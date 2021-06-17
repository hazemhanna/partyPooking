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
    
    @IBOutlet weak var currentReservationTableViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var endedReservationTableViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var cancelReservationTableViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var currentReservationTableView: UITableView!
    @IBOutlet weak var endedReservationTableView: UITableView!
    @IBOutlet weak var canceledReservationTableView: UITableView!
    @IBOutlet weak var currentLabel : UILabel!
    @IBOutlet weak var endedLabel : UILabel!
    @IBOutlet weak var canceledLabel : UILabel!
    @IBOutlet weak var titleLabel : UILabel!

    private let reservationVM = ReservationViewModel()
    var disposeBag = DisposeBag()
    
    
    
    var currentReservation: [Reservation]=[]{
        didSet {
            if currentReservation.count > 0{
                let dynamicTableHeight = currentReservation.count * CellHeight
                currentReservationTableViewConstraint.constant = CGFloat(dynamicTableHeight)
            }else{
                currentReservationTableViewConstraint.constant = 73
            }
        }
    }
    
    
    var endedReservation: [Reservation]=[]{
        didSet {
            if endedReservation.count > 0{
                let dynamicTableHeight = endedReservation.count * CellHeight
                endedReservationTableViewConstraint.constant = CGFloat(dynamicTableHeight)
            }else{
                endedReservationTableViewConstraint.constant = 73
            }
        }
    }
    
    var cancelReservation: [Reservation]=[]{
        didSet {
            if cancelReservation.count > 0{
                let dynamicTableHeight = currentReservation.count * CellHeight
                cancelReservationTableViewConstraint.constant = CGFloat(dynamicTableHeight)
            }else{
                cancelReservationTableViewConstraint.constant = 73
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentReservationTableView.register(UINib(nibName: "ReservationTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        endedReservationTableView.register(UINib(nibName: "ReservationTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        canceledReservationTableView.register(UINib(nibName: "ReservationTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")

        setUPLocalize()
        reservationVM.showIndicator()
        getReservation()
        
    }
    
    
    func setUPLocalize(){
        titleLabel.text = "myReservation".localized
        currentLabel.text = "current".localized
        endedLabel.text = "ended".localized
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

extension ReservationViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == currentReservationTableView{
            return currentReservation.count
        }else if tableView == endedReservationTableView{
            return endedReservation.count
        }else{
            return cancelReservation.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ReservationTableViewCell
        if tableView == currentReservationTableView{
            cell.cancelBtn.isHidden = false
            cell.confirmNumberLabel.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
            cell.NumberLabel.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
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
                }
               self.present(vc!, animated: true, completion: nil)
           }
        }else if tableView == endedReservationTableView{
            cell.cancelBtn.isHidden = true
            cell.confirmNumberLabel.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
            cell.NumberLabel.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        }else{
            cell.cancelBtn.isHidden = true
            cell.confirmNumberLabel.textColor = #colorLiteral(red: 0.9529411765, green: 0.3137254902, blue: 0.3137254902, alpha: 1)
            cell.NumberLabel.textColor = #colorLiteral(red: 0.9529411765, green: 0.3137254902, blue: 0.3137254902, alpha: 1)

        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == currentReservationTableView{
            let destinationVC = ReservetionDetailsVc.instantiateFromNib()
            self.navigationController?.pushViewController(destinationVC!, animated: true)
        }else if tableView == endedReservationTableView{
            let destinationVC = ReservetionDetailsVc.instantiateFromNib()
            destinationVC!.ended = true
            self.navigationController?.pushViewController(destinationVC!, animated: true)
        }else{
            let destinationVC = ReservetionDetailsVc.instantiateFromNib()
            destinationVC!.cancel = true
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
        self.currentReservationTableView.reloadData()
        self.endedReservationTableView.reloadData()
        self.canceledReservationTableView.reloadData()
        
    }
}, onError: { (error) in
    self.reservationVM.dismissIndicator()
    displayMessage(title: "", message: "Something went wrong in getting data", status: .error, forController: self)
}).disposed(by: disposeBag)
}

}
