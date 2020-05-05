//
//  GameOver.swift
//  Bubble Pop
//
//  Created by Dov Royal on 4/5/20.
//  Copyright © 2020 Dov Royal. All rights reserved.
//  Class for the game over screen

import UIKit

class GameOver: UIViewController {
    
    struct HighScores: Codable {
        var name: String
        var score: String
    }
    
    var finalScore = ""
    var finalName = ""
    
    @IBOutlet weak var scoreLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = finalScore
        
        let score = HighScores(name: finalName, score: finalScore) // score final score in the struct so that it can be saved to a file
        
        navigationItem.hidesBackButton = true // hide navigation bar back button
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(self.goHome)) // create a new button that goes back to the new game screen
    }
    
    @objc func goHome() {
        performSegue(withIdentifier: "GoHome", sender: self)
    }

}
