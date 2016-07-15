//
//  InfoViewController.swift
//  Pokémon Finder
//
//  Created by Mohamed Ayadi on 7/15/16.
//  Copyright © 2016 Mohamed Ayadi. All rights reserved.
//

import UIKit
import MapKit

class InfoViewController: UIViewController {
    @IBOutlet weak var founderName: UITextField!

    @IBOutlet weak var pokemonName: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var passedName: String?
    var passedImage: String?
    var passedLat: Double?
    var passedLong: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.founderName.text = self.passedName
        self.imageView.image = UIImage.init(named: self.passedImage!)
    }


    @IBAction func goBackButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func navigatebuttonPressed(sender: AnyObject) {
        self.openMapForPlace()
        
           }

    
    func openMapForPlace() {
        
      
        
        let latitute:CLLocationDegrees =  self.passedLat!
        let longitute:CLLocationDegrees =  self.passedLong!
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitute, longitute)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.passedName
        mapItem.openInMapsWithLaunchOptions(options)
        
    }
}
