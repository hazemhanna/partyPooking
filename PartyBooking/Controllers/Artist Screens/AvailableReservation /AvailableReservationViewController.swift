//
//  AvailableReservationViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/9/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import FSCalendar
import RxSwift
import RxCocoa

class AvailableReservationViewController: UIViewController{
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var availbleReservationBtn: UIButton!
    @IBOutlet weak var closeReservationBtn: UIButton!
    @IBOutlet weak var changePriceBtn: UIButton!
    @IBOutlet weak var hiddenView : UIView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var alertLabel : UILabel!
    @IBOutlet weak var selectLabel : UILabel!
    private let artistProfile = ArtistProfileViewModel()
    var disposeBag = DisposeBag()
    var dates = [String]()
    var availabeDdates = [String]()
    var notAvailabeDdates = [String]()

    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_EN")
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        changePriceBtn.layer.cornerRadius = 7
        availbleReservationBtn.layer.cornerRadius = 7
        closeReservationBtn.layer.cornerRadius = 7
        setUPLocalize()

        calendar.dataSource = self
        calendar.delegate = self
        calendar.allowsMultipleSelection = true
        //calendar.register(DIYCalendarCell.self, forCellReuseIdentifier: "cell")
        let month = Calendar.current.component(.month, from: Date())
        let year = Calendar.current.component(.year, from: Date())
         self.artistProfile.showIndicator()
        self.getAvailability(month: String(month) , year: String(year))
    }
    
    func setUPLocalize(){
        alertLabel.text = "chooseDate".localized
        selectLabel.text = "SelectDate".localized
        titleLabel.text = "Avialable".localized
        availbleReservationBtn.setTitle("availableBtn".localized, for: .normal)
        closeReservationBtn.setTitle("closeBtn".localized, for: .normal)
        changePriceBtn.setTitle("changePrice".localized, for: .normal)
        
        
        if "lang".localized  == "en" {
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
    
    @IBAction func availableBtn(sender: UIButton) {
        self.artistProfile.showIndicator()

        availability(dates: self.dates, status: "active")
    }
    
    @IBAction func dissAvailableBtn(sender: UIButton) {
        self.artistProfile.showIndicator()
        availability(dates: self.dates, status: "inactive")

    }
    
    @IBAction func changeBtn(sender: UIButton) {

    }
    
}


extension AvailableReservationViewController :FSCalendarDataSource, FSCalendarDelegate , FSCalendarDelegateAppearance, UIGestureRecognizerDelegate{
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if  monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_EN")
        let selectedDate: String = dateFormatter.string(from: date)
        self.dates.append(selectedDate)
        
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_EN")
        let selectedDate: String = dateFormatter.string(from: date)
        self.dates.removeAll{$0 == selectedDate}
    }
    

    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = self.dateFormatter.string(from: date)

        if self.notAvailabeDdates.contains(dateString) {
            return 3
        }
        
        if self.availabeDdates.contains(dateString) {
            return 3
        }
        return 0
        
    }

    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        let key = self.dateFormatter.string(from: date)
        if self.availabeDdates.contains(key) {
            return [appearance.eventDefaultColor, appearance.eventDefaultColor, appearance.eventDefaultColor]
        }
        
        if self.notAvailabeDdates.contains(key) {
            return [UIColor.red,UIColor.red,UIColor.red]
        }
        return nil
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let currentPageDate = calendar.currentPage
        let month = Calendar.current.component(.month, from: currentPageDate)
        let year = Calendar.current.component(.year, from: currentPageDate)
         self.artistProfile.showIndicator()
        self.getAvailability(month: String(month), year: String(year))
    }
    
}

extension AvailableReservationViewController {
    func availability(dates: [String], status : String) {
        artistProfile.availability(dates: dates, status: status).subscribe(onNext: { (data) in
            if data.status ?? false {
                self.artistProfile.dismissIndicator()
                if ("lang".localized == "en") {
                 displayMessage(title: "", message: "the operation was successfull", status: .success, forController: self)
                }else{
                 displayMessage(title: "", message: "تمت العملية بنجاح", status: .success, forController: self)
                }
            }
        }, onError: { (error) in
            self.artistProfile.dismissIndicator()
        }).disposed(by: disposeBag)
     }
    
    
    func getAvailability(month: String, year : String) {
        artistProfile.getAvailability(month: month, year: year).subscribe(onNext: { (data) in
            if data.status ?? false {
                self.artistProfile.dismissIndicator()
                for date in data.result?.pricesDates ?? [] {
                    self.availabeDdates.append(date.date ?? "" )
                }
                
                for date in data.result?.notAvailableDates ?? [] {
                    self.notAvailabeDdates.append(date.date ?? "" )
                }
                
            }
        }, onError: { (error) in
            self.artistProfile.dismissIndicator()
        }).disposed(by: disposeBag)
     }
}
