//
//  AddPokeViewController.swift
//  Pokémon Finder
//
//  Created by Mohamed Ayadi on 7/15/16.
//  Copyright © 2016 Mohamed Ayadi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AddPokeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate {
    @IBOutlet weak var pickerView: UIPickerView!
    
    var passedLat = 0.0
    var passedLong = 0.0
    
    let ref = FIRDatabase.database().reference()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var founderNameTextField: UITextField!
    var data = ["None", "Bulbasaur", "Ivysaur", "Venusaur", "Charmander", "Charmeleon", "Charizard", "Squirtle", "Wartortle", "Blastoise", "Caterpie", "Metapod", "Butterfree", "Weedle", "Kakuna", "Beedrill", "Pidgey", "Pidgeotto", "Pidgeot", "Rattata", "Raticate", "Spearow", "Fearow", "Ekans", "Arbok", "Pikachu", "Raichu", "Sandshrew", "Sandslash", "Nidoran F", "Nidorina", "Nidoqueen", "Nidoran M", "Nidorino", "Nidoking", "Clefairy", "Clefable", "Vulpix", "Ninetails", "Jigglypuff", "Wigglytuff", "Zubat", "Golbat", "Oddish", "Gloom", "Vileplume", "Paras", "Parasect", "Venonat", "Venomoth", "Diglett", "Dugtrio", "Meowth", "Persian", "Psyduck", "Golduck", "Mankey", "Primeape", "Growlithe", "Arcanine", "Poliwag", "Poliwhirl", "Poliwrath", "Abra", "Kadabra", "Alakazam", "Machop", "Machoke", "Machamp", "Bellsprout", "Weepinbell", "Victreebel", "Tentacool", "Tentacruel", "Geodude", "Graveler", "Golem", "Ponyta", "Rapidash", "Slowpoke", "Slowbro", "Magnemite", "Magneton", "Farfetch'd", "Doduo", "Dodrio", "Seel", "Dewgong", "Grimer", "Muk", "Shellder", "Cloyster", "Gastly", "Haunter", "Gengar", "Gengar", "Drowzee", "Hypno", "Krabby", "Kingler", "Voltorb", "Electrode", "Exeggcute", "Exeggutor", "Cubone", "Marowak", "Hitmonlee", "Hitmonchan", "Lickitung", "Koffing", "Weezing", "Rhyhorn", "Rhydon", "Chansey", "Tangela", "Kangaskhan", "Horsea", "Seadra", "Goldeen", "Seaking", "Staryu", "Starmie", "Mr. Mime", "Scyther", "Jynx", "Electabuzz", "Magmar", "Pinsir", "Tauros", "Magikarp", "Gyarados", "Lapras", "Ditto", "Eevee", "Vaporeon", "Jolteon", "Flareon"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sahreButtonPressed(sender: AnyObject) {
        if self.founderNameTextField.text == ""{
            self.founderNameTextField.text = "Anonymous"
            let selectedValue = self.pickerView.selectedRowInComponent(0)
            let tempArray = ["Anonymous", selectedValue, self.passedLat, self.passedLong,self.data[self.pickerView.selectedRowInComponent(0)]]
            self.ref.childByAutoId().setValue(tempArray)
            
        }else{
            let selectedValue = self.pickerView.selectedRowInComponent(0)
            let tempArray = [self.founderNameTextField.text! as String, selectedValue, self.passedLat, self.passedLong,self.data[self.pickerView.selectedRowInComponent(0)]]
            self.ref.childByAutoId().setValue(tempArray)
            
            
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func goBackButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.imageView.image = UIImage.init(named: "\(row)")
    }
    

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return true
        
    }
    
    
    
}
