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
    // MARK: - Inner Types
    private struct Constants {
        static let actionButtonSize = CGSize(width: 35, height: 35)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabbarControllers()
        setupApperence()
        selectedIndex = 1
    }
    private func setupApperence() {
        tabBar.barTintColor = #colorLiteral(red: 0.0431372549, green: 0.4039215686, blue: 0.5725490196, alpha: 1)
        tabBar.unselectedItemTintColor = UIColor.white
        UITabBar.appearance().tintColor = UIColor.white
    }
    private func createTabbarControllers() {
        let systemTags = [RoundedTabBarItem.more, RoundedTabBarItem.search, RoundedTabBarItem.reservations, RoundedTabBarItem.account]
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
        }
        viewController.title = customTabBarItem.title
        viewController.tabBarItem = customTabBarItem.tabBarItem
        let nav = UINavigationController(rootViewController: viewController)
        return nav
    }
}
