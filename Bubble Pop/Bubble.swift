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
    var colour: String
    var id: Int
    
    init(x: Int, y: Int, colour: String, id: Int) {
        self.x = x
        self.y = y
        self.width = 50
        self.height = 50
        self.button = UIButton(type: .custom)
        self.colour = colour
        self.id = id
        
        switch colour { // set the number of points based on bubble colour
        case "Red.png":
            self.points = 1
        case "Purple.png":
            self.points = 2
        case "Green.png":
            self.points = 5
        case "Blue.png":
            self.points = 8
        case "Brown.png":
            self.points = 10
        default:
            self.points = 1
        }
        
        super.init(frame: .zero)
        
        createBubble() // create a bubble button straight away after it is called
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createBubble() {
        self.frame = CGRect(x: x, y: y, width: width, height: height) // set coord and size of button
        self.layer.cornerRadius = 0.5 * self.bounds.size.width // create a round button
        self.setImage(UIImage(named: colour), for: .normal)
        self.clipsToBounds = true
        
        pulsate()
    }
    
    func removeBubble() {
        self.removeFromSuperview()
    }
    
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.3
        pulse.fromValue = 0.8
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
    }
}
