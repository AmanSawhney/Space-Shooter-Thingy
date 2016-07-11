//
//  Ground3.swift
//  ModernSpaceShooter
//
//  Created by Gagandeep Sawhney on 8/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit

class Ground3: Enemies {
    func didLoadFromCCB() {
        super.health = 1
        super.multiplier = 1
    }
}
