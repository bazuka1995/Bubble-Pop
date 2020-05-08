//
//  HighScreen.swift
//  Bubble Pop
//
//  Created by Dov Royal on 4/5/20.
//  Copyright © 2020 Dov Royal. All rights reserved.
//  Class for the high scores screen

import UIKit

class HighScores: UIViewController {
    
    @IBOutlet weak var score1: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let userDefaults = UserDefaults.standard // access shared defaults object
        
        let highScores: [String:Int] = userDefaults.object(forKey: "allScores") as? [String:Int] ?? [:] // if dictionary doesnt exist, start with empty dictionary
        
        let sortedScores = highScores.sorted { $0.1 > $1.1 } // Sort highscores in descending order by score
        
        for (name, score) in sortedScores {
            score1.text = "\(name)'s score is \(score)"
        }
    }
}
