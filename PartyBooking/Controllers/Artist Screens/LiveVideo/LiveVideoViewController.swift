//
//  LiveVideoViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/8/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class LiveVideoViewController: UIViewController {

    @IBOutlet weak var closeBtn : UIButton!
    @IBOutlet weak var messageTF : UITextField!
    fileprivate var returnHandler : IQKeyboardReturnKeyHandler!

    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeBtn.layer.cornerRadius = closeBtn.frame.width / 2
        messageTF.layer.cornerRadius = 50
        updateReturnHandler()
    }
    
    func updateReturnHandler(){
        if returnHandler == nil {
            returnHandler = IQKeyboardReturnKeyHandler(controller: self)
        }else{
            returnHandler.removeResponderFromView(self.view)
            returnHandler.addResponderFromView(self.view)
        }
        returnHandler.lastTextFieldReturnKeyType = .done
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
         self.navigationController?.navigationBar.isHidden = true
         self.tabBarController?.tabBar.isHidden = true

        
     }
     override func viewWillDisappear(_ animated: Bool) {
         self.navigationController?.navigationBar.isHidden = false
         self.tabBarController?.tabBar.isHidden = false

     }

     @IBAction func backButton(sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
     }
     
  

}
