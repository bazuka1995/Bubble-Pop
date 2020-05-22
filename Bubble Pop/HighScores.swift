//
//  HighScreen.swift
//  Bubble Pop
//
//  Created by Dov Royal on 4/5/20.
//  Copyright © 2020 Dov Royal. All rights reserved.
//  Class for the high scores screen
//  11995305

import UIKit

class HighScores: UIViewController {
    
    let userDefaults = UserDefaults.standard // access shared defaults object
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    @IBOutlet weak var score1: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationBar.rightBarButtonItem = UIBarButtonItem(title: "Clear all scores", style: .plain, target: self, action: #selector(self.showPopUp)) // create a new button that clears all high scores
        
        let highScores: [String:Double] = userDefaults.object(forKey: "allScores") as? [String:Double] ?? [:] // if dictionary doesnt exist, start with empty dictionary
        
        let sortedScores = highScores.sorted { $0.1 > $1.1 } // Sort highscores in descending order by score
        
        if (sortedScores.isEmpty) {
            score1.text = "No highscores have been saved yet" // set placeholder text for when highscores is empty
        } else {
            var count = 0
            score1.text = ""
            score1.numberOfLines = 0
            for key in sortedScores {
                if (count < 5) { // make sure only the top 5 highscores are displayed
                    score1.text! += "\(key.key)'s high score is \(key.value) \n \n"
                    count += 1
                }
            }
        }
    }
    
    @objc func showPopUp() { // show popup to warn user before clearing all scores
        let alert = UIAlertController(title: "Clear high scores", message: "Are you sure you want to clear all high scores? This cannot be undone.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            UserDefaults.standard.removeObject(forKey: "allScores")
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
}
