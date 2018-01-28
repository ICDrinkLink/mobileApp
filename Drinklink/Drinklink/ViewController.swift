//
//  ViewController.swift
//  Drinklink
//
//  Created by Matt Malarkey on 27/01/2018.
//  Copyright © 2018 Matthew Malarkey. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
import FirebaseAuth

class ViewController: UIViewController, CLLocationManagerDelegate {
	
//MARK: Attributes
	var locationManager = CLLocationManager()
	
	var uidGlobal = ""
	var trackingIdGlobal = ""
	
	let DEFAULT_PAIR_CODE_TEXT = "You pair code is: ..."
	
	//@IBOutlet weak var getPairCodeTimer: UIActivityIndicatorView!
	@IBOutlet weak var toggleLocationTracking: UISwitch!
	@IBOutlet weak var trackingLabel: UILabel!
	@IBOutlet weak var appInfoTextArea: UITextView!
	
//MARK: ViewController Methods
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		FirebaseApp.configure()
		
		//Authorise and get tracking number
		//getPairCodeTimer.startAnimating()
		authoriseAndGetTrackingID()
		
		//Set to allow background updates
		locationManager.allowsBackgroundLocationUpdates = true
		
		//Set component states and properties
		toggleLocationTracking.isOn = false
		trackingLabel.isHidden = true
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//Do any additional setup after loading the view, typically from a nib.
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		//Dispose of any resources that can be recreated.
	}
	
//MARK: Actions
	@IBAction func toggleTrackingSwitchChanged(_ sender: Any) {
		//Enable tracking, get and set tracking number
		if toggleLocationTracking.isOn {
			//Start tracking
			self.startReceivingLocationChanges()
		} else {
			//Stop tracking
			locationManager.stopUpdatingLocation()
		}
		
		//Display/hide labels as appropriate
		self.trackingLabel.isHidden = !self.trackingLabel.isHidden
	}
	
//MARK: Tracking Methods
	func authoriseAndGetTrackingID()  {
		Auth.auth().signInAnonymously() { (user, error) in
			if error != nil {
				print("Some error occured whilst signing in")
			} else {
				self.uidGlobal = user!.uid
				
				//Add this uid to users
				let db = Firestore.firestore()
				db.collection("users").document(self.uidGlobal).setData(["doPair" : true]) { err in
					if let err = err {
						print("Error writing document: \(err)")
					} else {
						print("Document successfully written")
					}
				}
				//Get tracking number
				self.getTrackingID(uid: self.uidGlobal)
			}
		}
	}
	
	func getTrackingID(uid : String) {
		let db = Firestore.firestore()
		let snapshotListener = db.collection("users").document(uid)
			.addSnapshotListener { documentSnapshot, error in
				guard let document = documentSnapshot else {
					print("Error fetching document: \(error!)")
					return
				}
				
				let pairCode = document.data()!["pairCode"]
				if pairCode != nil {
					let paidCodeNotNil = (pairCode as? String)!
					self.trackingIdGlobal = paidCodeNotNil
					self.trackingLabel.text = "You pair code is: " + paidCodeNotNil
					//self.getPairCodeTimer.stopAnimating()
				}
		}
		
		//find a way to do this after we have our tracking ID
		//snapshotListener.remove()
	}
	
	func sendLocation(position : GeoPoint, time : Date) {
		let db = Firestore.firestore()
		db.collection("users")
			.document(uidGlobal)
			.collection("locations")
			.addDocument(data : ["pos" : position, "time" : time]) { err in
			if let err = err {
				print("Error writing document: \(err)")
			} else {
				print("Coordinates successfully written")
				db.collection("users")
					.document(self.uidGlobal)
					.updateData(["lastPos" : position, "lastTime" : time])
			}
		}
	}
	
//MARK: CoreLocation Methods
	func startReceivingLocationChanges() {
		//Request here
		locationManager.requestAlwaysAuthorization()
		
		let authorizationStatus = CLLocationManager.authorizationStatus()
		if authorizationStatus != .authorizedAlways {
			// User has not authorized access to location information.
			return
		}
		// Do not start services that aren't available.
		if !CLLocationManager.locationServicesEnabled() {
			// Location services is not available.
			return
		}
		// Configure and start the service.
		//locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
		locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
		locationManager.distanceFilter = 1.0  // In meters.
		locationManager.delegate = self
		locationManager.startUpdatingLocation()
	}
	
	func locationManager(_ manager: CLLocationManager,  didUpdateLocations locations: [CLLocation]) {
		let lastLocation = locations.last!

		let position = GeoPoint(latitude : lastLocation.coordinate.latitude, longitude : lastLocation.coordinate.longitude)
		sendLocation(position : position, time : lastLocation.timestamp)
		
		// Do something with the location.
		print("user latitude = \(lastLocation.coordinate.latitude)")
		print("user longitude = \(lastLocation.coordinate.longitude)")
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		if let error = error as? CLError, error.code == .denied {
			// Location updates are not authorized.
			manager.stopUpdatingLocation()
			return
		}
		// Notify the user of any errors.
		print("Error \(error)")
	}
}

//MARK: Backgroumd Launch Handles
//- not needed so long as user doesnt quit app.
/*func application(_ application: UIApplication,
willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
print("wakeup")
if launchOptions![UIApplicationLaunchOptionsKey.location] != nil {
print("bg1")
}
return true

}


func application(_ application: UIApplication,
didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
print("wakeup")
if launchOptions![UIApplicationLaunchOptionsKey.location] != nil {
print("bg2")
}
return true
}*/

