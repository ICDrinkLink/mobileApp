//
//  AppDelegate.swift
//  Drinklink
//
//  Created by Matt Malarkey on 27/01/2018.
//  Copyright © 2018 Matthew Malarkey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	
	/*@IBAction func btnTrackUserPressed(_ sender: Any) {
		LocationDelegate.escalateLocationServiceAuthorization();
	}*/

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}
/*
	let locationManager = CLLocationManager()
	
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
*/

}

