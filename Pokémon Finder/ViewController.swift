//
//  ViewController.swift
//  Pokémon Finder
//
//  Created by Mohamed Ayadi on 7/15/16.
//  Copyright © 2016 Mohamed Ayadi. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import GoogleMobileAds

class ViewController: UIViewController, MKMapViewDelegate, GADBannerViewDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var get = 0
    let ref = FIRDatabase.database().reference()
    var name: String?
    var imageName: String?
    var lat: Double?
    var long: Double?
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //ADMob Config
        
        let request = GADRequest()
        bannerView.adUnitID = "ca-app-pub-8672557971515294/8290488968"
        bannerView.rootViewController = self
        bannerView.loadRequest(request)
            

        self.get = 1
        
        locationManager.requestWhenInUseAuthorization()
        
        
   
        
        self.retrievePok()
    }
    
    
    
    @IBAction func ZoomToMyLocation(sender: AnyObject) {
        //Zoom in to the user Location
        self.mapView.setRegion(MKCoordinateRegionMake(self.mapView.userLocation.coordinate, MKCoordinateSpanMake(0.005, 0.005)), animated: true)
        
    }
    
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        if self.get == 1{
            self.get = self.get + 1
            self.mapView.setRegion(MKCoordinateRegionMake(self.mapView.userLocation.coordinate, MKCoordinateSpanMake(0.005, 0.005)), animated: true)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "fill"{
            
            if self.locationManager.location?.coordinate.latitude == nil || self.locationManager.location?.coordinate.longitude == nil{
                let alert = UIAlertController(title: "Alert", message: "Pokemon Finder cannot open the page because your device is not connected to the internet.", preferredStyle: .Alert)
                let okayButton = UIAlertAction(title: "Okay", style: .Cancel, handler: { (UIAlertAction) in
                    return
                })
                alert.addAction(okayButton)
                self.presentViewController(alert, animated: true, completion: nil)
            }else{
            
            let dvc = segue.destinationViewController as! AddPokeViewController
            dvc.passedLat = self.locationManager.location!.coordinate.latitude
            dvc.passedLong = self.locationManager.location!.coordinate.longitude
            }
        }
        if segue.identifier == "info"{
              let dvc = segue.destinationViewController as! InfoViewController
                dvc.passedImage = self.imageName
                dvc.passedName = self.name
                dvc.passedLat = self.lat
                dvc.passedLong = self.long
            
        }
    }
    
    
    func retrievePok(){
        self.ref.observeEventType(.ChildAdded, withBlock:  { (snapshot) in
            
            var tempArray = []
            tempArray = snapshot.value as! NSArray
            
            
            let point = MKPointAnnotation()
            
            
            
            point.coordinate.latitude = tempArray[2] as! Double
            point.coordinate.longitude = tempArray[3] as! Double
            point.title = tempArray[4] as? String
            point.subtitle = "\(tempArray[1])"
            self.mapView.addAnnotation(point)
            self.mapView.reloadInputViews()
            
            
        })
        
    }
    
    
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isEqual(mapView.userLocation) {
            return nil
        }else {
            let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            pin.canShowCallout = true
            pin.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
            return pin
        }
    }
    
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        self.name = (view.annotation?.title)!
        self.imageName = (view.annotation?.subtitle)!
        self.lat = view.annotation?.coordinate.latitude
        self.long = view.annotation?.coordinate.longitude
        
        self.performSegueWithIdentifier("info", sender: nil)
    }
    
}//End of the VC class

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    
    
}//End of the extension
