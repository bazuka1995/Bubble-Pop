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
    var score = 0
    
    @IBOutlet weak var timeLeft: UILabel!
    
    @IBOutlet weak var welcomeNav: UINavigationItem!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        welcomeNav.title = "Hello " + finalName
        timeLeft.text = String(gameTime)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.counter), userInfo: nil, repeats: true)
        
        //Top left (20,177)
        //Top right (348,177)
        //Bottom left (20,832)
        //Bottom right (348, 832)
        
        var bubble = Bubble(x: 20, y: 177, colour: UIColor.blue)
        
        self.view.addSubview(bubble)
        
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
    
    func updateScore() {
        score += 1
        scoreLabel.text = String(score)
    }

}
