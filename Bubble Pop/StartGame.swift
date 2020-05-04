//
//  StartGame.swift
//  Bubble Pop
//
//  Created by Dov Royal on 4/5/20.
//  Copyright © 2020 Dov Royal. All rights reserved.
//

import UIKit

class StartGame: UIViewController {
    
    var seconds = 30
    var name = ""
    
    @IBAction func startGame(_ sender: Any) {
        name = nameField.text!
    }
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var timerSlider: UISlider!
    
    @IBAction func updateSlider(_ sender: UISlider) {
        seconds = Int(sender.value)
        timerLabel.text = String(seconds) + " seconds"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Game") {
            let gameVC = segue.destination as! Game
            gameVC.finalName = nameField.text!
            gameVC.gameTime = seconds
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
