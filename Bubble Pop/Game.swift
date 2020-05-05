//
//  Game.swift
//  Bubble Pop
//
//  Created by Dov Royal on 4/5/20.
//  Copyright © 2020 Dov Royal. All rights reserved.
//  Class for the game screen

import UIKit

class Game: UIViewController {
    
    var finalName = "" // Name of the player passed in from startgame viewcontroller
    var gameTime = 60 // Game time passed in from startgame viewcontroller
    var timer = Timer() // Timer function
    var score = 0 // player score
    var minX = 20 // Min and max x and y coordinates
    var maxX = 348 // for buttons
    var minY = 177
    var maxY = 832
    
    let colour = ["Red.png", "Purple.png", "Green.png", "Blue.png", "Brown.png"] // store colours for the bubble
    
    @IBOutlet weak var timeLeft: UILabel! // Time left ui label in top left corner
    
    @IBOutlet weak var welcomeNav: UINavigationItem! // Navigation bar
    
    @IBOutlet weak var scoreLabel: UILabel! // Score label
    
    override func viewDidLoad() {
        welcomeNav.title = "Hello " + finalName // Update navbar title
        timeLeft.text = String(gameTime) // Update time left title
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.counter), userInfo: nil, repeats: true) // create timer and start counting down as soon as the viw is loaded
        
        super.viewDidLoad()
    }
    
    @objc func counter() { // update timer every 1 sec
        gameTime -= 1
        timeLeft.text = String(gameTime)
        
        let x = Int.random(in: minX...maxX)
        let y = Int.random(in: minY...maxY)
        let c = Int.random(in:0...4)
        
        var bubble = Bubble(x: x, y: y, colour: colour[c]) // create bubble with random coord
        bubble.addTarget(self, action: #selector(self.updateScore), for: .touchUpInside) // add action to button when pressed
        
        self.view.addSubview(bubble)
        
        if (gameTime == 0) { // stop timer when it reaches 0
            timer.invalidate()
            performSegue(withIdentifier: "GameOver", sender: self) // go to game over screen
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //
        if (segue.identifier == "GameOver") {
            let gameOverVC = segue.destination as! GameOver
            gameOverVC.finalScore = String(score)
        }
    }
    
    @objc func updateScore(bubble: Bubble) { // update the score when a button is pressed
        score += bubble.points
        scoreLabel.text = String(score)
        
        bubble.removeBubble()
    }

}
