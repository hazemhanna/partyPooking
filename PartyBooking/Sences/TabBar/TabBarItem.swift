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
    case  more, search,reservations, account
}
extension RoundedTabBarItem {
    var title: String {
        switch self {
        case .more:
            return "more"
        case .search:
            return "search"
        case .reservations:
            return "reservations"
        case .account:
            return "account"
        default:
            return ""
        }
    }
    var tag: Int {
        switch self {
        case .more:
            return 1
        case .search:
            return 2
        case .reservations:
            return 3
        case .account:
            return 4
        }
    }
    var image: UIImage? {
        switch self {
        case .more:
            return UIImage(named: "more")
        case .search:
            return UIImage(named: "search")
        case .reservations:
            return UIImage(named: "calendar")
        case .account:
            return UIImage(named: "user")
        }
    }
    var tabBarItem: UITabBarItem {
        let tabItem = UITabBarItem(title: title, image: image, tag: tag)
        return tabItem
    }
}
