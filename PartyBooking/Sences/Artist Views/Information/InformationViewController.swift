//
//  InformationViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/8/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {

    @IBOutlet weak var nextBtn : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.layer.cornerRadius = 7

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
                let destinationVC = ArtistAccountViewController.instantiateFromNib()
               self.navigationController?.pushViewController(destinationVC!, animated: true)
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
          if unchecked {
              sender.setImage(UIImage(named:"checked.png"), for: .normal)
              unchecked = false
          }
          else {
              sender.setImage( UIImage(named:"unchecked.png"), for: .normal)
              unchecked = true
          }
      }
    
}
