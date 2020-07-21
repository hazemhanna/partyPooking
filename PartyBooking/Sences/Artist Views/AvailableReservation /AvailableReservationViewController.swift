//
//  AvailableReservationViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/9/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import FSCalendar

class AvailableReservationViewController: UIViewController,FSCalendarDataSource, FSCalendarDelegate{
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var availbleReservationBtn: UIButton!
    @IBOutlet weak var closeReservationBtn: UIButton!
    @IBOutlet weak var changePriceBtn: UIButton!
    @IBOutlet weak var hiddenView : UIView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var alertLabel : UILabel!
    @IBOutlet weak var selectLabel : UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.allowsMultipleSelection = true
        changePriceBtn.layer.cornerRadius = 7
        availbleReservationBtn.layer.cornerRadius = 7
        closeReservationBtn.layer.cornerRadius = 7
        setUPLocalize()

    }
    
    func setUPLocalize(){
        alertLabel.text = "chooseDate".localized
        selectLabel.text = "SelectDate".localized
        titleLabel.text = "Avialable".localized
        availbleReservationBtn.setTitle("availableBtn".localized, for: .normal)
        closeReservationBtn.setTitle("closeBtn".localized, for: .normal)
        changePriceBtn.setTitle("changePrice".localized, for: .normal)
        
        
        if MOLHLanguage.currentAppleLanguage() == "en" {
            let font = UIFont(name: "Georgia-Bold", size: 14)
            let font2 = UIFont(name: "Georgia-Bold", size: 8)
            alertLabel.font = font2
            selectLabel.font = font2
            titleLabel.font =  font
            availbleReservationBtn.titleLabel!.font =  font
            closeReservationBtn.titleLabel!.font =  font
            changePriceBtn.titleLabel!.font =  font
        }
      }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
            
        }
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFormatter.locale = Locale(identifier: "en_EN")
        let selectedDate: String = dateFormatter.string(from: date)
        print(selectedDate)
        
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFormatter.locale = Locale(identifier: "en_EN")
        let selectedDate: String = dateFormatter.string(from: date)
        print(selectedDate)
        
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
    
    @IBAction func hiddenViewButton(sender: UIButton) {
        hiddenView.isHidden = true
    }
    
    
}

