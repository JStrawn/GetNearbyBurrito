//
//  RestaurantSearchResults.swift
//  FindNearbyBurrito
//
//  Created by Jay Strawn on 8/8/18.
//  Copyright © 2018 Jay Strawn. All rights reserved.
//

import Foundation
 
public struct RestaurantSearchResultsRawInfo: Codable {
  var results: [RestaurantRawInfo]
}

public struct RestaurantRawInfo: Codable {
  var name: String
  var geometry: GeometryRawInfo
  var vicinity: String
  var price_level: Int
}

public struct GeometryRawInfo: Codable {
  var location: LocationRawInfo
}

public struct LocationRawInfo: Codable {
  var lat: Double
  var lng: Double
}
