//
//  InfoViewController.swift
//  Pokémon Finder
//
//  Created by Mohamed Ayadi on 7/15/16.
//  Copyright © 2016 Mohamed Ayadi. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    @IBOutlet weak var founderName: UITextField!

    @IBOutlet weak var imageView: UIImageView!
    
    var passedName: String?
    var passedImage: String?
    var passedLat: Double?
    var passedLong: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.founderName.text = self.passedName

    }


    @IBAction func goBackButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func navigatebuttonPressed(sender: AnyObject) {
    }

}
