//
//  File.swift
//  PartyBooking
//
//  Created by MAC on 7/2/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation
import Foundation
import UIKit
enum RoundedTabBarItem {
    case search,reservations, account,more,artistMore,artistreservations, artistaccount,artistAvailable,home,live,userLive
}

extension RoundedTabBarItem {
    var title: String {
        switch self {
         case .search:
            return "search".localized
        case .reservations:
            return "reservation".localized
       case .account:
        return "account".localized
        case .more:
            return "more".localized
        case .artistMore:
            return "more".localized
        case .artistaccount:
            return "account".localized
        case .artistAvailable:
            return "availabel".localized
        case .artistreservations:
            return "reservation".localized
        case .home:
            return "home".localized
        case .live:
            return "live".localized
        case .userLive:
            return "live".localized
            
        default:
            return ""
        }
    }
    
    
    var tag: Int {
        switch self {
        case .search:
            return 1
        case .reservations:
            return 2
        case .account:
            return 3
        case .more:
            return 4
        case .artistMore:
            return 5
        case .artistaccount:
            return 6
        case .artistAvailable:
            return 7
        case .artistreservations:
            return 8
        case .home:
            return 0
        case .live:
            return 9
        case .userLive:
            return 10
        }
    }
    
    var image: UIImage? {
        switch self {
        case .search:
            return UIImage(named: "user-1")
        case .reservations:
            return UIImage(named: "calendar")
       case .account:
               return UIImage(named: "user")
         case .more:
              return UIImage(named: "more")
        case .artistMore:
            return UIImage(named: "more")
        case .artistaccount:
            return UIImage(named: "user")
        case .artistAvailable:
            return UIImage(named: "list")
        case .artistreservations:
            return UIImage(named: "calendar")
        case .home:
            return UIImage(named: "user-1")
        case .live:
            return UIImage(named: "calendar-1")
        case .userLive:
            return UIImage(named: "calendar-1")
        }
    }
    var tabBarItem: UITabBarItem {
        let tabItem = UITabBarItem(title: "", image: image, tag: tag)
        return tabItem
    }
}
