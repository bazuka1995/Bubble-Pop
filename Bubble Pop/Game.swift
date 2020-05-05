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
    var maxBubble = 15 // Maximum number of bubbles on the screen
    var timer = Timer() // Timer function
    var score = 0 // player score
    var minX = 20 // Min and max x and y coordinates
    var maxX = 348 // for buttons
    var minY = 177
    var maxY = 832
    var run = false // stores whether the game timer is 1 second less than the user set game time
    
    var colours: [String] = [] // array to store colours
    
    @IBOutlet weak var timeLeft: UILabel! // Time left ui label in top left corner
    
    @IBOutlet weak var welcomeNav: UINavigationItem! // Navigation bar
    
    @IBOutlet weak var scoreLabel: UILabel! // Score label
    
    override func viewDidLoad() {
        welcomeNav.title = "Hello " + finalName // Update navbar title
        timeLeft.text = String(gameTime) // Update time left title
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.counter), userInfo: nil, repeats: true) // create timer and start counting down as soon as the viw is loaded
        
        setUpRandomArray()
        
        super.viewDidLoad()
    }
    
    @objc func counter() { // update timer every 1 sec
        gameTime -= 1
        timeLeft.text = String(gameTime)
        
        
        let x = Int.random(in: minX...maxX)
        let y = Int.random(in: minY...maxY)
        let c = Int.random(in: 0...99)
        
        var bubble = Bubble(x: x, y: y, colour: colours[c]) // create bubble with random coord
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
            gameOverVC.finalName = finalName
        }
    }
    
    @objc func updateScore(bubble: Bubble) { // update the score when a button is pressed
        score += bubble.points
        scoreLabel.text = String(score)
        
        bubble.removeBubble()
    }
    
    func setUpRandomArray() { // set up random array to store colours with weights
        let red = [String](repeating: "Red.png", count: 40) // sets up each individual colour array with weighting
        let purple = [String](repeating: "Purple.png", count: 30)
        let green = [String](repeating: "Green.png", count: 15)
        let blue = [String](repeating: "Blue.png", count: 10)
        let brown = [String](repeating: "Brown.png", count: 5)

        colours = red + purple + green + blue + brown // add each single array to the larger array

        colours.shuffle() // randomise array so that it is truelly chosen at random
    }

}
