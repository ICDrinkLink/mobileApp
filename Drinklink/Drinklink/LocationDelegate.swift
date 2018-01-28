//
//  LocationDelegate.swift
//  Drinklink
//
//  Created by Matt Malarkey on 27/01/2018.
//  Copyright © 2018 Matthew Malarkey. All rights reserved.
//

import UIKit
import CoreLocation

class LocationDelegte : CLLocationManagerDelegate {
	
	var locationManager = CLLocationManager()
	
	func determineMyCurrentLocation()
	{
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestAlwaysAuthorization()
		
		if CLLocationManager.locationServicesEnabled() {
			locationManager.startUpdatingLocation()
			//locationManager.startUpdatingHeading()
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		let userLocation:CLLocation = locations[0] as CLLocation
		
		// Call stopUpdatingLocation() to stop listening for location updates,
		// other wise this function will be called every time when user location changes.
		
		// manager.stopUpdatingLocation()
		
		print("user latitude = \(userLocation.coordinate.latitude)")
		print("user longitude = \(userLocation.coordinate.longitude)")
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
	{
		print("Error \(error)")
	}
	
	
	func enableLocationServices() {
		locationManager.delegate = self
		
		switch (CLLocationManager.authorizationStatus()) {
		case .notDetermined:
			// Request when-in-use authorization initially
			locationManager.requestWhenInUseAuthorization()
			break
			
		case .restricted, .denied:
			// Disable location features
			disableMyLocationBasedFeatures()
			break
			
		case .authorizedWhenInUse:
			// Enable basic location features
			enableMyWhenInUseFeatures()
			break
			
		case .authorizedAlways:
			// Enable any of your app's location features
			enableMyAlwaysFeatures()
			break
		}
	}
	
	func disableMyLocationBasedFeatures() {
		//cleanup code
	}
	
	func enableMyWhenInUseFeatures() {
		//enable when in use features
	}
	
	func enableMyAlwaysFeatures() {
		//enable always in user
	}
	
	func escalateLocationServiceAuthorization() {
		// Escalate only when the authorization is set to when-in-use
		if CLLocationManager.authorizationStatus() != .authorizedAlways {
			locationManager.requestAlwaysAuthorization()
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		switch status {
		case .restricted, .denied:
			// Disable your app's location features
			disableMyLocationBasedFeatures()
			break
			
		case .authorizedWhenInUse:
			// Enable only your app's when-in-use features.
			enableMyWhenInUseFeatures()
			break
			
		case .authorizedAlways:
			// Enable any of your app's location services.
			enableMyAlwaysFeatures()
			break
			
		case .notDetermined:
			break
		}
	}



}
