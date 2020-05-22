//
//  NewGame.swift
//  Bubble Pop
//
//  Created by Dov Royal on 4/5/20.
//  Copyright © 2020 Dov Royal. All rights reserved.
//  Class for the new game screen (i.e. screen with the New game and High Score buttons)
//  11995305

import UIKit

class NewGame: UIViewController {
    
    @IBOutlet weak var titleButton: DesignableButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true // hide navbar back button
        
        titleButton.isUserInteractionEnabled = false // disable clickable button
    }

}
