//
//  Bubble.swift
//  Bubble Pop
//
//  Created by Dov Royal on 5/5/20.
//  Copyright © 2020 Dov Royal. All rights reserved.
//

import UIKit

class Bubble: UIButton {
    
    var points: Int // how many points a user will get when pressing the button
    var x: Int
    var y: Int
    var width: Int
    var height: Int
    var button: UIButton // set up initial button type
    var colour: UIColor
    
    init(x: Int, y: Int, colour: UIColor) {
        self.x = x
        self.y = y
        self.width = 50
        self.height = 50
        self.points = 10
        self.button = UIButton(type: .custom)
        self.colour = colour
        super.init(frame: .zero)
        
        createBubble() // create a bubble button straight away after it is called
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createBubble() {
        self.frame = CGRect(x: x, y: y, width: width, height: height) // set coord and size of button
        self.layer.cornerRadius = 0.5 * self.bounds.size.width // create a round button
        self.backgroundColor = colour
        self.clipsToBounds = true
        self.addTarget(self, action: #selector(self.bubbleTapped), for: .touchUpInside) // add an action to the button when clicked
    }
    
    func removeBubble() {
        self.removeFromSuperview()
    }
    
    @objc func bubbleTapped() {
        
    }
}
