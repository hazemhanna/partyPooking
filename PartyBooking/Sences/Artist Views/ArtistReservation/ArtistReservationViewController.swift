//
//  ArtistReservationViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/9/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import FSCalendar


class ArtistReservationViewController: UIViewController ,FSCalendarDataSource, FSCalendarDelegate{
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var reservationTableView: UITableView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchTf: UITextField!
    @IBOutlet weak var searchImage: UIImage!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        reservationTableView.register(UINib(nibName: "ArtistReservationTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        setUPLocalize()
    }
    
    
    func setUPLocalize(){
           titleLabel.text = "reservation".localized
           searchTf.placeholder = "searchIn".localized
        if MOLHLanguage.currentAppleLanguage() == "en" {
             let font = UIFont(name: "Georgia-Bold", size: 14)
             titleLabel.font = font
             searchTf.font =  font
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
}


extension ArtistReservationViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ArtistReservationTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
        
    }
    
    
}
