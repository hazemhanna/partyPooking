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
    
    @IBOutlet weak var partyTimeLabel: UILabel!
    @IBOutlet weak var partyDateLabel: UILabel!

    
    @IBOutlet weak var backButton: UIButton! {
           didSet {
               backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPLocalize()
    }
    
    
    func setUPLocalize(){
           titleLabel.text = "reservation".localized
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
        
            let vc = NoArtistAvailableVc.instantiateFromNib()
            vc?.onClickDone = {
            self.presentingViewController?.dismiss(animated: true)
            }
           self.present(vc!, animated: true, completion: nil)
    
        
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
