//
//  PartyDateVc.swift
//  PartyBooking
//
//  Created by MAC on 29/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit
import FSCalendar

class PartyDateVc: UIViewController ,FSCalendarDataSource, FSCalendarDelegate{
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var titleLabel: UILabel!
    var from = String()
    var to = String()
    var offer = false
    
    
    @IBOutlet weak var backButton: UIButton! {
           didSet {
               backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPLocalize()
        calendar.delegate = self
        calendar.dataSource = self
    }
    
    func setUPLocalize(){
        titleLabel.text = "reservation".localized
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_EN")
        let selectedDate: String = dateFormatter.string(from: date)
        
        let date2 = Date()
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "yyyy-MM-dd"
        formatter2.locale = Locale(identifier: "en_EN")
        let result = formatter2.string(from: date2)

        if offer {
            if selectedDate <= to &&  selectedDate >= from {
                Helper.saveDate(date: selectedDate)
                self.navigationController?.popViewController(animated: true)
            }else{
                if "lang".localized == "ar" {
                    displayMessage(title: "", message: "التاريخ خارج العرض", status: .error, forController: self)
                }else{
                    displayMessage(title: "", message: "date out of offer", status: .error, forController: self)
                }
            }
        }else{
            if selectedDate < result{
                if "lang".localized == "ar" {
                    displayMessage(title: "", message: "لا يمكنك اخيار يوم سابق لتاريخ  اليوم", status: .error, forController: self)
                }else{
                    displayMessage(title: "", message: "you cant chosse date befor today", status: .error, forController: self)
                }
            }else{
                Helper.saveDate(date: selectedDate)
                self.navigationController?.popViewController(animated: true)
            }
        }
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
    
}
