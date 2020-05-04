//
//  Game.swift
//  Bubble Pop
//
//  Created by Dov Royal on 4/5/20.
//  Copyright © 2020 Dov Royal. All rights reserved.
//  Class for the game screen

import UIKit

class Game: UIViewController {
    
    var finalName = ""
    var gameTime = 30
    var timer = Timer()
    
    @IBOutlet weak var timeLeft: UILabel!
    
    @IBOutlet weak var welcomeNav: UINavigationItem!
    
    
    
    override func viewDidLoad() {
        welcomeNav.title = "Hello " + finalName
        timeLeft.text = String(gameTime)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.counter), userInfo: nil, repeats: true)
        
        super.viewDidLoad()
    }
    
    @objc func counter() {
        gameTime -= 1
        timeLeft.text = String(gameTime)
        
        if (gameTime == 0) {
            timer.invalidate()
            performSegue(withIdentifier: "GameOver", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "GameOver") {
            navigationItem.title = "Home"
        }
    }

}
