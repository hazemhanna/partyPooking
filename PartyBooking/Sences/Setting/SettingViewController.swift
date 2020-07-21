//
//  SettingViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/11/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import CollapseTableView
class SettingViewController: UITableViewController {
        var sections = sectionsData
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Auto resizing the height of the cell
            tableView.estimatedRowHeight = 44.0
            tableView.rowHeight = UITableView.automaticDimension
            tableView.separatorColor = UIColor.rgb(235, green: 235, blue: 235)
            self.view.backgroundColor = UIColor.rgb(235, green: 235, blue: 235)
            let titleLabel = UILabel(frame: CGRect(x:view.frame.width/1.5, y: 20, width:view.frame.width, height: view.frame.height))
            titleLabel.text = "setting".localized
                      titleLabel.textColor = UIColor.white
                      titleLabel.textAlignment = .center
                      navigationItem.titleView = titleLabel
                      navigationController?.navigationBar.barTintColor = UIColor.rgb(43, green: 180, blue: 177)
               
        }
    }

extension SettingViewController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
         return sections.count
     }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return sections[section].collapsed ? 0 : sections[section].items.count
     }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return UITableView.automaticDimension
       }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CollapsibleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CollapsibleTableViewCell ??
            CollapsibleTableViewCell(style: .default, reuseIdentifier: "cell")
        let item: Item = sections[indexPath.section].items[indexPath.row]
        cell.nameLabel.text = item.name
        if indexPath.row == 0 && MOLHLanguage.currentAppleLanguage() == "ar" {
            cell.rightImage.isHidden = false
        }else if indexPath.row == 1 && MOLHLanguage.currentAppleLanguage() == "en" {
        cell.rightImage.isHidden = false
        }
        return cell
    }
     
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
             if MOLHLanguage.currentAppleLanguage() != "ar"{
                MOLH.setLanguageTo("ar")
                MOLH.reset()
             }
        }else if indexPath.row == 1{
           if MOLHLanguage.currentAppleLanguage() != "en"{
                MOLH.setLanguageTo("en")
                MOLH.reset()
            }
        }
    }
    
     // Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
         
         header.titleLabel.text = sections[section].name
         header.arrowLabel.text = ">"
         header.setCollapsed(sections[section].collapsed)
         header.section = section
         header.delegate = self
         return header
     }
     
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 44.0
     }
  override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
      return 1.0
  }
 
}

// MARK: - Section Header Delegate
extension SettingViewController: CollapsibleTableViewHeaderDelegate {
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !sections[section].collapsed
        sections[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
    
}
