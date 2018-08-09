//
//  Restaurant.swift
//  FindNearbyBurrito
//
//  Created by Jay Strawn on 8/7/18.
//  Copyright © 2018 Jay Strawn. All rights reserved.
//

import Foundation

class Restaurant {
  var name: String
  var latitude: Double
  var longitude: Double
  var address: String
  var price: Int?
  
  init(name: String, latitude: Double, longitude: Double, address: String) {
    self.name = name
    self.latitude = latitude
    self.longitude = longitude
    self.address = address
  }
  
  func getPriceString() -> String {
    
    var priceString = ""
    
    switch self.price {
    case 0:
      priceString = "Free"
    case 1:
      priceString = "$"
    case 2:
      priceString = "$$"
    case 3:
      priceString = "$$$"
    case 4:
      priceString = "$$$$"
    default:
      priceString = ""
    }
    return priceString
  }
}
