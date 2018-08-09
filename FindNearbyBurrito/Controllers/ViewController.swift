//
//  ViewController.swift
//  FindNearbyBurrito
//
//  Created by Jay Strawn on 8/7/18.
//  Copyright © 2018 Jay Strawn. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import MapKit

class ViewController: UIViewController {
  
  private let locationManager = CLLocationManager()
  private var hasData: Bool?
  private var networkingSharedInstance = Networking()
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    activityIndicator.isHidden = false
    activityIndicator.startAnimating()
    reloadTableViewAfterNetworkCall()
    
    self.locationManager.requestWhenInUseAuthorization()
    
    if CLLocationManager.locationServicesEnabled() {
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
      locationManager.startUpdatingLocation()
    }
  }
}

  extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {
        print("error: no location")
        return }
      locationManager.stopUpdatingLocation()
      print("locations = \(locValue.latitude) \(locValue.longitude)")
      networkingSharedInstance.getRestaurantsNearLocation(lattitude: String(locValue.latitude), longitude: String(locValue.longitude), completion:  {_ in })
    }
  }
  
  extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return networkingSharedInstance.restaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CollectionViewCell
      cell.roundTopAndBottom(radius: cell.frame.width * 0.03)
      cell.addShadow()

      let currentRestaurant = networkingSharedInstance.restaurants[indexPath.row]
      cell.nameLabel.text = currentRestaurant.name
      cell.addressLabel.text = currentRestaurant.address
      cell.infoLabel.text = currentRestaurant.getPriceString()
      
      return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
      vc.currentRestaurant = networkingSharedInstance.restaurants[indexPath.row]
      self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let width = view.frame.width * 0.95
      let height = view.frame.height * 0.15
      return CGSize(width: width, height: height)
    }
}

// MARK: - ReloadCollectionViewDelegate
extension ViewController: ReloadCollectionViewDelegate {
  func didGetResult(_ success: Bool) {
    self.hasData = success
    DispatchQueue.main.async {
      self.collectionView.reloadData()
      self.activityIndicator.stopAnimating()
      self.activityIndicator.isHidden = true
    }
  }
  
  func reloadTableViewAfterNetworkCall() {
    networkingSharedInstance.delegate = self
  }
}

