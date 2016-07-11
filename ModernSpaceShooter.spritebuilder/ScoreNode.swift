//
//  ScoreNode.swift
//  ModernSpaceShooter
//
//  Created by Gagandeep Sawhney on 8/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit

class ScoreNode: CCNode {
    weak var scorelabel: CCLabelTTF!
    override func update(delta: CCTime) {
        scorelabel.string = "\(score)"
    }
}
