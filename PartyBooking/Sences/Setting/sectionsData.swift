//
//  File.swift
//  PartyBooking
//
//  Created by MAC on 7/11/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation
public struct Item {
    var name: String
    public init(name: String) {
        self.name = name
    }
}

public struct Section {
    var name: String
    var items: [Item]
    var collapsed: Bool
    
    public init(name: String, items: [Item], collapsed: Bool = false) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}

public var sectionsData: [Section] = [
    Section(name: "language".localized, items: [
        Item(name: "arabic".localized),
        Item(name: "english".localized)
    ]),
    Section(name: "terms".localized, items: []),
 
]
