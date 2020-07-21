//
//  Color.swift
//  PartyBooking
//
//  Created by MAC on 7/4/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    static func rgb(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let navigationColor = UIColor.rgb(43, green: 180, blue: 177)
    static let tabBarColor = UIColor.rgb(11, green: 103, blue: 146)
    static let backgroundColor = UIColor.rgb(235, green: 235, blue: 235)
    static let fontColor = UIColor.rgb(112, green: 112, blue: 112)

    

}
