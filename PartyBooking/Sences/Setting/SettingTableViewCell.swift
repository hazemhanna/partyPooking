//
//  CollapsibleTableViewCell.swift
//  ios-swift-collapsible-table-section
//
//  Created by Yong Su on 7/17/17.
//  Copyright © 2017 Yong Su. All rights reserved.
//

import UIKit

class CollapsibleTableViewCell: UITableViewCell {
    
    
    let nameLabel = UILabel()
    let rightImage = UIImageView()
    
    // MARK: Initalizers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
          backgroundColor = UIColor.white

        let marginGuide = contentView.layoutMarginsGuide
        
        // configure nameLabel
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        
        // configure detailLabel
        contentView.addSubview(rightImage)
        rightImage.image = UIImage(named: "right")
        rightImage.isHidden = true
        rightImage.translatesAutoresizingMaskIntoConstraints = false
        rightImage.centerYAnchor.constraint(equalTo: marginGuide.centerYAnchor).isActive = true
        rightImage.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor,constant: -16).isActive = true
        rightImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        rightImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
