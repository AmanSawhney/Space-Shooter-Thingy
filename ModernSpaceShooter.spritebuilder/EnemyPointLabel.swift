//
//  EnemyPointLabel.swift
//  ModernSpaceShooter
//
//  Created by Gagandeep Sawhney on 8/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit

class EnemyPointLabel: CCNode {
    weak var label: CCLabelTTF!
    func destroy() {
        removeFromParent()
    }
}
