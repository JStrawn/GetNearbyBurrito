//
//  DetailViewController.swift
//  FindNearbyBurrito
//
//  Created by Jay Strawn on 8/8/18.
//  Copyright © 2018 Jay Strawn. All rights reserved.
//

import UIKit
import GoogleMaps

class DetailViewController: UIViewController {
  
  // MARK: - Injections
  var currentRestaurant: Restaurant!
  
  // MARK: - Outlets
  @IBOutlet weak var mapView: GMSMapView!
  @IBOutlet weak var infoView: UIView!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var infoLabel: UILabel!
  
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    
    self.title = currentRestaurant.name
    addressLabel.text = currentRestaurant.address
    infoLabel.text = currentRestaurant.getPriceString()
    
    let cornerRadius = mapView.frame.width * 0.08
    mapView.roundTopAndBottom(radius: cornerRadius)
    infoView.roundTop(radius: cornerRadius)
    
    let camera = GMSCameraPosition.camera(withLatitude: currentRestaurant.latitude, longitude: currentRestaurant.longitude, zoom: 15.0)
    self.mapView.camera = camera
    
    let marker = GMSMarker()
    marker.position = CLLocationCoordinate2D(latitude: currentRestaurant.latitude, longitude: currentRestaurant.longitude)
    
    let width = self.view.frame.width * 0.16
    let height = self.view.frame.height * 0.1
    marker.icon = self.imageWithImage(image: UIImage(named: "Pin")!, scaledToSize: CGSize(width: width, height: height))
    
    marker.map = mapView
  }
  
  func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
    image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
    let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return newImage
  }
}

