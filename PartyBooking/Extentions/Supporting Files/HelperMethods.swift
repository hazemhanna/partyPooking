//
//  HelperMethods.swift
//  PartyBooking
//
//  Created by MAC on 12/06/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import Foundation
import Foundation
import SwiftMessages


//MARK:- Display normal Alert
public func displayMessage(title: String, message: String, status: Theme, forController controller: UIViewController) {
    let success = MessageView.viewFromNib(layout: .cardView)
    success.configureTheme(status, iconStyle: .default )
    success.configureDropShadow()
    success.configureContent(title: title, body: message)
    success.button?.isHidden = true
    var successConfig = SwiftMessages.defaultConfig
    successConfig.duration = .seconds(seconds: 1)
    successConfig.presentationStyle = .top
    successConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
    SwiftMessages.show(config: successConfig, view: success)
}

