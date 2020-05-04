//
//  GameOver.swift
//  Bubble Pop
//
//  Created by Dov Royal on 4/5/20.
//  Copyright © 2020 Dov Royal. All rights reserved.
//  Class for the game over screen

import UIKit

class GameOver: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(self.goHome))
    }
    
    @objc func goHome() {
        performSegue(withIdentifier: "GoHome", sender: self)
    }

}
