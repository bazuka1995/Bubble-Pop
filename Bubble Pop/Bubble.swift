//
//  Bubble.swift
//  Bubble Pop
//
//  Created by Dov Royal on 5/5/20.
//  Copyright © 2020 Dov Royal. All rights reserved.
//  11995305

import UIKit

class Bubble: UIButton {
    
    var points: Double // how many points a user will get when pressing the button
    var x: Int
    var y: Int
    var width: Int
    var height: Int
    var button: UIButton // set up initial button type
    var colour: String
    var id: Int
    
    init(x: Int, y: Int, colour: String, id: Int) { // set the parameters of the bubble
        self.x = x
        self.y = y
        self.width = 50
        self.height = 50
        self.button = UIButton(type: .custom)
        self.colour = colour
        self.id = id
        
        switch colour { // set the number of points based on bubble colour
        case "Red.png":
            self.points = 1.0
        case "Pink.png":
            self.points = 2.0
        case "Green.png":
            self.points = 5.0
        case "Blue.png":
            self.points = 8.0
        case "Black.png":
            self.points = 10.0
        default:
            self.points = 1.0
        }
        
        super.init(frame: .zero)
        
        createBubble() // create a bubble button after parameters are set
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createBubble() {
        self.frame = CGRect(x: x, y: y, width: width, height: height) // set coord and size of button
        self.layer.cornerRadius = 0.5 * self.bounds.size.width // create a round button
        self.setImage(UIImage(named: colour), for: .normal)
        self.clipsToBounds = true
        
        self.pulsate()
    }
    
    func removeBubble() {
        self.removeFromSuperview()
    }
}
