//
//  GameOver.swift
//  Bubble Pop
//
//  Created by Dov Royal on 4/5/20.
//  Copyright © 2020 Dov Royal. All rights reserved.
//  Class for the game over screen
//  11995305

import UIKit

class GameOver: UIViewController {
    
    var finalScore = ""
    var finalName = ""
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    @IBOutlet weak var gameOverLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameOverLabel.text = "Game Over, \(finalName)!"
        
        scoreLabel.text = finalScore
        
        navigationItem.hidesBackButton = true // hide navigation bar back button
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(self.goHome)) // create a new button that goes back to the new game screen
        
    }
    
    @objc func goHome() {
        performSegue(withIdentifier: "GoHome", sender: self)
    }

}
