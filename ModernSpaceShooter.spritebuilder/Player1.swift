//
//  Player1.swift
//  ModernSpaceShooter
//
//  Created by Gagandeep Sawhney on 8/19/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit
var playerHealth: Double!

class Player1: CCSprite {
    func didLoadFromCCB() {
        physicsBody.sensor = true
        playerHealth = 10
        
    }
    override func onEnter() {
        super.onEnter()
        
        schedule("shoot", interval: 0.3)
        
    }
    
    func shoot() {
        
        var bullet = CCBReader.load("Effects and Projectiles/ccbFiles/TinyMissle")
        bullet.physicsBody.collisionType = "playerBullet"
        bullet.physicsBody.sensor = true
        bullet.position = positionInPoints
        bullet.scale = scale * 1.5
        bullet.zOrder = 10
        parent.addChild(bullet)
        bullet.physicsBody.applyImpulse(ccp(70, 0))
        if bullet.position.x > position.x + parent.contentSizeInPoints.width {
            bullet.removeFromParentAndCleanup(true)
        }
        projectiles.append(bullet)
    }
}


