//
//  StartGame.swift
//  Bubble Pop
//
//  Created by Dov Royal on 4/5/20.
//  Copyright © 2020 Dov Royal. All rights reserved.
//  Class for the game preferences screen

import UIKit

class StartGame: UIViewController {
    
    var seconds = 60 // default game time
    var name = ""
    var maxBubbles = 15 // default max number of bubble
    
    @IBAction func startGame(_ sender: Any) {
        name = nameField.text!
    }
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var nameField: UITextField! // input field for user name
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var timerSlider: UISlider!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var maxLabel: UILabel!
    
    @IBOutlet weak var maxSlider: UISlider!
    
    @IBAction func updateSlider(_ sender: UISlider) { // update the timer label when sliding the slider
        seconds = Int(sender.value)
        timerLabel.text = String(seconds) + " seconds"
    }
    
    @IBAction func updateMaxSlider(_ sender: UISlider) {
        maxBubbles = Int(sender.value)
        maxLabel.text = "Maximum bubbles: " + String(maxBubbles)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Game") {
            let gameVC = segue.destination as! Game
            gameVC.finalName = nameField.text! // pass user name into the game screen
            gameVC.gameTime = seconds // pass user selected game time into the game screen
            gameVC.maxBubble = maxBubbles
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.isEnabled = false // start with disabled button until user enters name
        
        nameField.addTarget(self, action: #selector(self.validateName), for: .editingChanged) // add target to namefield so that the name can be validated
    }
    
    @objc func validateName() { // validate name field to make sure its between 2-15 characters. Disable button for invalid name
        if (nameField.text!.count < 2) {
            errorLabel.text = "Please enter a name that is greater than 2 characters"
            startButton.isEnabled = false
        } else if (nameField.text!.count > 15) {
            errorLabel.text = "Please enter a name that is less than 15 characters"
            startButton.isEnabled = false
        } else {
            errorLabel.text = ""
            startButton.isEnabled = true
        }
    }
}
