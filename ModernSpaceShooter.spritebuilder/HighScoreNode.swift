//
//  HighScoreNode.swift
//  ModernSpaceShooter
//
//  Created by Gagandeep Sawhney on 8/19/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit

class HighScoreNode: CCNode {
    weak var scorelabel: CCLabelTTF!
    override func update(delta: CCTime) {
        var highScore = NSUserDefaults.standardUserDefaults().integerForKey("highscore")
        scorelabel.string = "\(highScore)"
    }
}
