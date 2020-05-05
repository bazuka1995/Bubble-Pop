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
    
    @IBAction func startGame(_ sender: Any) {
        name = nameField.text!
    }
    
    @IBOutlet weak var nameField: UITextField! // input field for user name
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var timerSlider: UISlider!
    
    @IBAction func updateSlider(_ sender: UISlider) { // update the timer label when sliding the slider
        seconds = Int(sender.value)
        timerLabel.text = String(seconds) + " seconds"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Game") {
            let gameVC = segue.destination as! Game
            gameVC.finalName = nameField.text! // pass user name into the game screen
            gameVC.gameTime = seconds // pass user selected game time into the game screen
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
