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
    var score: Double = 0.0 // player score
    var screenWidth = UInt32(UIScreen.main.bounds.width)
    var screenHeight = UInt32(UIScreen.main.bounds.height)
    var minX = 20 // Min and max x and y coordinates
    var maxX = 348 // for buttons
    var minY = 177
    var maxY = 832
    var run = false // stores whether the game timer is 1 second less than the user set game time
    var id = 1 // Store unique id of each bubble button
    
    var colours: [String] = [] // array to store colours
    var bubbleArray: [Bubble] = [] // array to store all the bubbles
    var lastBubble: [String] = [] // array to store the colour of the bubble last pressed
    
    var combo = 0 // keep track of how many of the same coloured bubbles are pressed consecutively
    
    @IBOutlet weak var timeLeft: UILabel! // Time left ui label in top left corner
    
    @IBOutlet weak var welcomeNav: UINavigationItem! // Navigation bar
    
    @IBOutlet weak var scoreLabel: UILabel! // Score label
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var comboLabel: UILabel!
    
    override func viewDidLoad() {
        setMaxCoord(name: String(UIDevice.current.name))
        
        comboLabel.text = String(combo)
        
        welcomeNav.title = "Hello " + finalName // Update navbar title
        timeLeft.text = String(gameTime) // Update time left title
        
        let userDefaults = UserDefaults.standard // access shared defaults object
        
        let highScores: [String:Double] = userDefaults.object(forKey: "allScores") as? [String:Double] ?? [:] // if dictionary doesnt exist, start with empty dictionary
        
        if (highScores[finalName] != nil) { // check to see that the users highscore has been saved before
            let sortedScores = highScores.sorted { $0.1 > $1.1 } // Sort highscores in descending order by score
            if let firstScore = sortedScores.first?.key { // get the key in first place
                highScoreLabel.text = String(highScores[firstScore]!) // Show the total highscore, not just the current user's highscore
            }
        } else {
            highScoreLabel.text = "---" // Display nothing if there hasnt been any scores yet
        }
        
        setUpRandomArray()
        
        addBubbles() // add first bubble before the timer has started
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.counter), userInfo: nil, repeats: true) // create timer and start counting down as soon as the viw is loaded
        
        super.viewDidLoad()
    }
    
    func setMaxCoord(name: String) { // Set the maximum coordinates a bubble can reach dynamically
        maxX = Int(0.85 * Double(screenWidth))
        
        if (name == "iPhone 11 Pro Max" || name == "iPhone 11 Pro" || name == "iPhone 11") { // Since these phones dont have a home button, some of the screen real estate is taken up by the on screen home button so the maximum coordinates are less than if the iphone had a physical home button
            maxY = Int(0.85 * Double(screenHeight))
        } else {
            maxY = Int(0.92 * Double(screenHeight))
        }
    }
    
    @objc func counter() { // update timer every 1 sec
        gameTime -= 1
        timeLeft.text = String(gameTime)
        
        removeBubbles()
        addBubbles()
        
        if (gameTime == 0) { // stop timer when it reaches 0
            timer.invalidate()
            performSegue(withIdentifier: "GameOver", sender: self) // go to game over screen
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) { // Function is run when view will dissapear
        let userDefaults = UserDefaults.standard // access shared defaults object
        
        var highScores: [String:Double] = userDefaults.object(forKey: "allScores") as? [String:Double] ?? [:] // if dictionary doesnt exist, start with empty dictionary
        
        if highScores[finalName] != nil { // Check to see if the users high score has been saved before
            if (score > highScores[finalName]!) { // Only save the highest score
                highScores[finalName] = score // add to dictionary
                
                userDefaults.set(highScores, forKey: "allScores")
            }
        } else { // otherwise, if highscore is nil, then save the first high score
            highScores[finalName] = score // since highscores is empty just add high score to dictionary
            
            userDefaults.set(highScores, forKey: "allScores")
        }
    }
    
    func removeBubbles() { // Delete bubbles
        if (bubbleArray.count > 2) { // make sure not to remove bubbles if there arent any on the screen
            let count = Int.random(in: 0...(bubbleArray.count-1)) // choose a random number of bubbles to remove from the screen
                
            for _ in stride(from: 1, through: count, by: 1) {
                let randomElement = bubbleArray.randomElement() // choose a random element to remove
                bubbleArray.remove(at: getIndex(id: randomElement!.id)) // remove bubble from array
                randomElement!.removeBubble() // remove bubble from screen
            }
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
        
        var bubbleButtons: Bubble
        
        for _ in stride(from: 1, to: count, by: 1) { // add a random number of bubbles each second
            repeat {
            
                let x = Int.random(in: minX...maxX)
                let y = Int.random(in: minY...maxY)
                let c = Int.random(in: 0...99)
                    
                bubbleButtons = Bubble(x: x, y: y, colour: colours[c], id: id) // create bubble with random coord
            
            } while checkOverlap(bubble: bubbleButtons)
            
            id += 1
                    
            bubbleButtons.addTarget(self, action: #selector(self.updateScore), for: .touchUpInside) // add action to button when pressed
            
            bubbleArray.append(bubbleButtons)
        }
        addBubblesToView()
    }
    
    func checkOverlap(bubble: Bubble) -> Bool { // check for button overlap before adding to bubble array
        
        for element in bubbleArray {
            let x = max(bubble.x, element.x) - min(bubble.x, element.x)
            let y = max(bubble.y, element.y) - min(bubble.y, element.y)
            
            if (x < 50 && y < 50) {
                return true
            }
        }
        return false
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
        if (lastBubble.count < 1) { // check if user has pressed more than 2 bubbles
            lastBubble.append(bubble.colour)
            
            score += bubble.points
            scoreLabel.text = String(score)
        } else {
            lastBubble.append(bubble.colour) // add the colour of the bubble that was most recently pressed
            
            if (lastBubble[0] == lastBubble[1]) { // if there are two of the same bubble colours pressed consecutively, add 50% to the score
                score += (bubble.points * 1.5)
                scoreLabel.text = String(score)
                combo += 1
                comboLabel.text = String(combo)
            } else {
                score += bubble.points
                scoreLabel.text = String(score)
                combo = 0 // reset to 0 since the user has pressed a different coloured bubble
                comboLabel.text = String(combo)
            }
            
            lastBubble[0] = lastBubble[1] // after adding the score, move the most recent button colour to the previous button press
            lastBubble.remove(at: 1)
        }
        
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
        let purple = [String](repeating: "Pink.png", count: 30)
        let green = [String](repeating: "Green.png", count: 15)
        let blue = [String](repeating: "Blue.png", count: 10)
        let brown = [String](repeating: "Black.png", count: 5)

        colours = red + purple + green + blue + brown // add each single array to the larger array

        colours.shuffle() // randomise array so that it is truelly chosen at random
    }

}
