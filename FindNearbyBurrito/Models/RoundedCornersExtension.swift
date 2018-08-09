//
//  RoundedCornersExtension.swift
//  FindNearbyBurrito
//
//  Created by Jay Strawn on 8/9/18.
//  Copyright © 2018 Jay Strawn. All rights reserved.
//

import UIKit

extension UIView {
  
  func roundTop(radius: CGFloat){
    self.clipsToBounds = true
    self.layer.cornerRadius = radius
    self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
  }
  
  func roundTopAndBottom(radius: CGFloat){
    self.clipsToBounds = true
    self.layer.cornerRadius = radius
    self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
  }
}
