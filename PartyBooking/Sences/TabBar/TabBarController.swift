//
//  TabBarController.swift
//  PartyBooking
//
//  Created by MAC on 7/2/20.
//  Copyright © 2020 MAC. All rights reserved.
//


enum HomeType {
    case user
    case artist
}

import Foundation
import UIKit

class TabBarController: UITabBarController {

    var type: HomeType = .user
    private struct Constants {
        static let actionButtonSize = CGSize(width: 35, height: 35)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabbarControllers()
        setupApperence()
        selectedIndex = 0
    }
    
    private func setupApperence() {
        tabBar.barTintColor = #colorLiteral(red: 0.0431372549, green: 0.4039215686, blue: 0.5725490196, alpha: 1)
        tabBar.unselectedItemTintColor = UIColor.white
        UITabBar.appearance().tintColor = UIColor.white
    }
    private func createTabbarControllers() {
        var systemTags : [RoundedTabBarItem] = []
        if type == .user {
         systemTags = [RoundedTabBarItem.search, RoundedTabBarItem.reservations, RoundedTabBarItem.account ,RoundedTabBarItem.more]
        }else{
            systemTags = [RoundedTabBarItem.artistaccount, RoundedTabBarItem.artistreservations, RoundedTabBarItem.artistAvailable ,RoundedTabBarItem.artistMore]
        }
        
        let viewControllers = systemTags.compactMap { self.createController(for: $0, with: $0.tag) }
        self.viewControllers = viewControllers
    }
    // MARK: - Actions
    @objc func dismissView(){
        self.dismiss(animated:true,completion:nil)
    }
    private func createController(for customTabBarItem: RoundedTabBarItem, with tag: Int) -> UINavigationController? {
        var viewController = UIViewController()
        switch customTabBarItem {
        case .more:
            viewController = MoreViewController.instantiateFromNib()!
        case .search:
            viewController = SearchViewController.instantiateFromNib()!
        case .reservations:
            viewController = ReservationViewController.instantiateFromNib()!
        case .account:
            viewController = AccountViewController.instantiateFromNib()!
        case .artistMore:
                viewController = ArtistMoreViewController.instantiateFromNib()!
        case .artistreservations:
                viewController = ArtistReservationViewController.instantiateFromNib()!
       case .artistaccount:
                viewController = ArtistAccountViewController.instantiateFromNib()!
        case .artistAvailable:
                viewController = AvailableReservationViewController.instantiateFromNib()!
        }
        viewController.title = customTabBarItem.title
        viewController.tabBarItem = customTabBarItem.tabBarItem
        let nav = UINavigationController(rootViewController: viewController)
        return nav
    }
}

