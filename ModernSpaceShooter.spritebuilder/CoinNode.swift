//
//  CoinNode.swift
//  ModernSpaceShooter
//
//  Created by Gagandeep Sawhney on 8/20/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit

class CoinNode: CCNode {
    weak var coinAmount: CCLabelTTF!
    override func update(delta: CCTime) {
        var coins = NSUserDefaults.standardUserDefaults().integerForKey("coins")
        coinAmount.string = "\(coins)"
    }
}
