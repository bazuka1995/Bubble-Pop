//
//  Game.swift
//  Bubble Pop
//
//  Created by Dov Royal on 4/5/20.
//  Copyright © 2020 Dov Royal. All rights reserved.
//  Class for the game screen

import UIKit
import Foundation

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
    var id = 1 // Store unique id of each bubble button
    
    var colours: [String] = [] // array to store colours
    var bubbleArray: [Bubble] = [] // array to store all the bubbles
    
    @IBOutlet weak var timeLeft: UILabel! // Time left ui label in top left corner
    
    @IBOutlet weak var welcomeNav: UINavigationItem! // Navigation bar
    
    @IBOutlet weak var scoreLabel: UILabel! // Score label
    
    override func viewDidLoad() {
        welcomeNav.title = "Hello " + finalName // Update navbar title
        timeLeft.text = String(gameTime) // Update time left title
        
        setUpRandomArray()
        
        addBubbles() // add first bubble before the timer has started
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.counter), userInfo: nil, repeats: true) // create timer and start counting down as soon as the viw is loaded
        
        super.viewDidLoad()
    }
    
    @objc func counter() { // update timer every 1 sec
        gameTime -= 1
        timeLeft.text = String(gameTime)
        
        addBubbles()
        removeBubbles()
        
        if (gameTime == 0) { // stop timer when it reaches 0
            timer.invalidate()
            performSegue(withIdentifier: "GameOver", sender: self) // go to game over screen
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) { // Function is run when view will dissapear
        let userDefaults = UserDefaults.standard // access shared defaults object
        
        var highScores: [String:Int] = userDefaults.object(forKey: "allScores") as? [String:Int] ?? [:] // if dictionary doesnt exist, start with empty dictionary
        
        if score > highScores[finalName]! { // Only save score if its greater than the users high score
            highScores[finalName] = score // add to dictionary
            
            userDefaults.set(highScores, forKey: "allScores")
        }
    }
    
    func removeBubbles() { // Delete bubbles
        let count = Int.random(in: 0...(bubbleArray.count-1)) // choose a random number of bubbles to remove from the screen
        
        for _ in stride(from: 1, through: count, by: 1) {
            let randomElement = bubbleArray.randomElement() // choose a random element to remove
            bubbleArray.remove(at: getIndex(id: randomElement!.id))
            randomElement!.removeBubble()
        }
    }
    
    func getIndex(id: Int) -> Int { // Find index of a bubble in the array
        var index: Int = 0
        for i in bubbleArray {
            if id == i.id { // if the bubble id being passed in exists in the bubble array, return the index
                return index
            }
            index += 1
        }
        return index
    }
    
    func addBubbles() { // Create bubbles
        let count = Int.random(in: 1...(maxBubble-bubbleArray.count)) // choose a random number of bubbles to add up to the maximum user preference
        
        for _ in stride(from: 1, to: count, by: 1) { // add a random number of bubbles each second
            let x = Int.random(in: minX...maxX)
            let y = Int.random(in: minY...maxY)
            let c = Int.random(in: 0...99)
            
            var bubbleButtons = Bubble(x: x, y: y, colour: colours[c], id: id) // create bubble with random coord
            
            id += 1
            
            bubbleButtons.addTarget(self, action: #selector(self.updateScore), for: .touchUpInside) // add action to button when pressed
            
            bubbleArray.append(bubbleButtons)
            
            addBubblesToView()
        }
    }
    
    func addBubblesToView() {
        for i in bubbleArray {
            self.view.addSubview(i)
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
        
        var index = 0
        for i in bubbleArray {
            if i.id == bubble.id { // find the bubble in the array that was clicked by comparing ids
                bubbleArray.remove(at: index)
            }
            index += 1
        }
        
        bubble.removeBubble() // remove bubble from view
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
