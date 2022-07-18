//
//  TabBarController.swift
//  PartyBooking
//
//  Created by MAC on 7/2/20.
//  Copyright © 2020 MAC. All rights reserved.
//


import Foundation
import UIKit

class TabBarController: UITabBarController {
    var type = Helper.getType()
    private struct Constants {
        static let actionButtonSize = CGSize(width: 35, height: 35)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabbarControllers()
        selectedIndex = 0
        if #available(iOS 15.0, *) {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.tintColor = #colorLiteral(red: 0.0431372549, green: 0.4039215686, blue: 0.5725490196, alpha: 1)
        tabBar.unselectedItemTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    private func createTabbarControllers() {
        var systemTags : [RoundedTabBarItem] = []
        if type == "artist" {
            systemTags = [RoundedTabBarItem.home,
                          RoundedTabBarItem.artistAvailable,
                          RoundedTabBarItem.live,
                          RoundedTabBarItem.artistaccount,
                          RoundedTabBarItem.artistMore]
            
        }else {
            systemTags = [RoundedTabBarItem.search,
                          RoundedTabBarItem.reservations,
                          RoundedTabBarItem.userLive,
                          RoundedTabBarItem.account,
                          RoundedTabBarItem.more]
         
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
        case .home:
            viewController = ArtistHomeVc.instantiateFromNib()!
        case .live:
            viewController = AllLiveVideoVC.instantiateFromNib()!
        case .userLive:
            viewController = AllLiveVideoVC.instantiateFromNib()!
        }
        viewController.title = customTabBarItem.title
        viewController.tabBarItem = customTabBarItem.tabBarItem
        let nav = UINavigationController(rootViewController: viewController)
        return nav
    }
}

