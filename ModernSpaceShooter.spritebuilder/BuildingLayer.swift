//
//  BuildingLayer.swift
//  ModernSpaceShooter
//
//  Created by Gagandeep Sawhney on 8/10/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class BuildingLayer: CCNode {
    weak var stones: CCSprite!
    weak var farstones: CCSprite!
    func didLoadFromCCB() {
        stones.physicsBody.sensor = true
        stones.physicsBody.velocity.x = -CGFloat(arc4random_uniform(80))
        if farstones != nil {
        farstones.physicsBody.sensor = true
        farstones.physicsBody.velocity.x = 0
        }
    }
}
