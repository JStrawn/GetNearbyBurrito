//
//  CollectionViewCell.swift
//  FindNearbyBurrito
//
//  Created by Jay Strawn on 8/7/18.
//  Copyright © 2018 Jay Strawn. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var infoLabel: UILabel!
  
  func addShadow() {
    self.contentView.layer.borderWidth = 1.0
    self.contentView.layer.borderColor = UIColor.clear.cgColor
    self.contentView.layer.masksToBounds = true
    
    self.layer.shadowColor = UIColor.gray.cgColor
    self.layer.shadowOffset = CGSize(width: 0, height: 0)
    self.layer.shadowRadius = 10.0
    self.layer.shadowOpacity = 0.3
    self.layer.masksToBounds = false
    self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
  }
  
}
