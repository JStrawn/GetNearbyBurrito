//
//  Networking.swift
//  FindNearbyBurrito
//
//  Created by Jay Strawn on 8/8/18.
//  Copyright © 2018 Jay Strawn. All rights reserved.
//

import Foundation

// MARK: Webservice Response
enum WebServiceError: Error {
  case DataEmptyError
  case ResponseError
}

// MARK: Session Protocol (for Mock Session XCTest)
protocol SessionProtocol {
  func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void ) -> URLSessionDataTask
}

// MARK: Network Call
class Networking {
  
  // MARK: URLSession
  lazy var session: SessionProtocol = URLSession.shared
  
  // MARK: Singleton
  static let sharedInstance = Networking()

  // MARK: - Injections
  var delegate: ReloadCollectionViewDelegate?
  var jsonString: String?
  var restaurants = [Restaurant]()
  
  func getRestaurantsNearLocation(lattitude: String, longitude: String, completion: @escaping (Error?) -> Void) {
    self.restaurants.removeAll()
    jsonString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(lattitude),\(longitude)&radius=1500&type=restaurant&keyword=burrito&key=\(googleAPIKey)"

    guard let url = URL(string: jsonString!) else { fatalError() }
    session.dataTask(with: url) { (data, response, error) in
      
      guard error == nil else {
        completion(WebServiceError.ResponseError)
        return
      }
      guard let data = data else {
        completion(WebServiceError.DataEmptyError)
        return
      }
      
      // MARK: Decode Data
      do {
        let decoder = JSONDecoder()
        let restaurantData = try decoder.decode(RestaurantSearchResultsRawInfo.self, from: data)
        
        let results = restaurantData.results
        
        for restaurant in results {
          let name = restaurant.name
          let address = restaurant.vicinity
          let lattitude = restaurant.geometry.location.lat
          let longitude = restaurant.geometry.location.lng
          
          let restaurantObject = Restaurant(name: name, latitude: lattitude, longitude: longitude, address: address)
          restaurantObject.price = restaurant.price_level
          
          self.restaurants.append(restaurantObject)
        }
      } catch let error {
        print("Error", error.localizedDescription)
      }
      let success = error == nil
      self.delegate?.didGetResult(success)
      }.resume()
  }
}

// MARK: SessionProcotol
extension URLSession: SessionProtocol {
}

  


