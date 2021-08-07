//
//  AllLiveVideoVC.swift
//  PartyBooking
//
//  Created by MAC on 29/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//



import UIKit
import RxSwift
import RxCocoa


class AllLiveVideoVC: UIViewController {
    
    @IBOutlet weak var liveTableView: UITableView!
    @IBOutlet weak var titleLabel : UILabel!
    var live = [LiveData]()

    private let liveVM = LiveViewModel()
    var disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        liveTableView.register(UINib(nibName: "AllLiveCell", bundle: nil), forCellReuseIdentifier: "AllLiveCell")
    }
    
    func setUPLocalize(){
        titleLabel.text = "live".localized
  }
    
    override func viewWillAppear(_ animated: Bool) {
        liveVM.showIndicator()
        getLive()
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func backButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension AllLiveVideoVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return live.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllLiveCell", for: indexPath) as! AllLiveCell
        cell.confic(imageUrl: self.live[indexPath.row].artistImage ?? "", name: self.live[indexPath.row].artistName ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

extension AllLiveVideoVC {

func getLive() {
    liveVM.getLive().subscribe(onNext: { (data) in
        self.liveVM.dismissIndicator()
        if data.status ?? false {
            self.live = data.result?.data ?? []
            self.liveTableView.reloadData()
        }
    }, onError: { (error) in
        self.liveVM.dismissIndicator()
        displayMessage(title: "", message: "Something went wrong in getting data", status: .error, forController: self)
    }).disposed(by: disposeBag)
 }
}
