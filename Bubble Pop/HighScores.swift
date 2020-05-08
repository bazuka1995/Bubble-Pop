//
//  HighScreen.swift
//  Bubble Pop
//
//  Created by Dov Royal on 4/5/20.
//  Copyright © 2020 Dov Royal. All rights reserved.
//  Class for the high scores screen

import UIKit

class HighScores: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let userDefaults = UserDefaults.standard // access shared defaults object
        
        var highScores: [String:Int] = userDefaults.object(forKey: "allScores") as? [String:Int] ?? [:] // if dictionary doesnt exist, start with empty dictionary
        
        for (name, score) in highScores { // 
            
        }
    }
}
