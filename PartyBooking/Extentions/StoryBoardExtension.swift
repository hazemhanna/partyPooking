//
//  StoryBoardExtension.swift
//  PartyBooking
//
//  Created by MAC on 7/2/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation
import UIKit
public enum AppStoryboard: String {

    // add more storyboard names here if needed
    case Main = "Main"
    public var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type,
                                             function: String = #function,
                                             line: Int = #line, file: String = #file) -> T {

        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID)," +
                "not found in \(self.rawValue) Storyboard.\nFile :" +
                "\(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        return scene
    }

    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}

extension UIViewController {
    
    // Not using static as it wont be possible to override to provide custom storyboardID then
    class var storyboardID: String {
        return "\(self)"
    }

    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    
    static func instantiateFromNib() -> Self? {
          func instantiateFromNib<T: UIViewController>(_ viewType: T.Type) -> T? {
              return Bundle.main.loadNibNamed(String(describing: T.self),
                                       owner: nil, options: nil)?.first
              as? T
          }
          return instantiateFromNib(self)
      }
    
}
