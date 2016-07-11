//
//  Ship2.swift
//  ModernSpaceShooter
//
//  Created by Gagandeep Sawhney on 8/12/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit

class Ship2: Enemies {
    func didLoadFromCCB() {
        super.health = 3
        super.multiplier = 10
        physicsBody.velocity.x = -10
        physicsBody.sensor = true
        schedule("randomHeight", interval: 1)
        schedule("shoot1", interval: 1.3)
        schedule("shoot2", interval: 2)
        var action = CCActionMoveTo(duration: CCTime(1), position: ccp( (self.contentSizeInPoints.width * 2 + position.x), position.y))
        runAction(action)
    }
    func randomHeight() {
        physicsBody.velocity.y = CGFloat(Float(arc4random_uniform(50)) * CCRANDOM_MINUS1_1())
        
    }
    func shoot1() {
        var move = CCActionEaseBounceOut(action: CCActionMoveBy(duration: 0.1, position: ccp( ((contentSize.width)/200), 0)))
        var moveBack = CCActionEaseBounceOut(action: move.reverse())
        var shakeSequence = CCActionSequence(array: [move, moveBack])
        var bullet = CCBReader.load("Effects and Projectiles/ccbFiles/BigMissle")
        bullet.physicsBody.collisionType = "enemyBullet"
        bullet.physicsBody.sensor = true
        bullet.position = ccp(position.x - contentSizeInPoints.width * 0.2 * CGFloat(scale), position.y - contentSizeInPoints.height * 0.3 * CGFloat(scale))
        bullet.scale = 1
        bullet.zOrder = 10
        bullet.scaleX = -1
        parent.addChild(bullet)
        bullet.physicsBody.applyImpulse(ccp(-50,CGFloat(10 * CCRANDOM_MINUS1_1())))
        projectiles.append(bullet)
    }
    func shoot2() {
        var move = CCActionEaseBounceOut(action: CCActionMoveBy(duration: 0.1, position: ccp( ((contentSize.width)/200), 0)))
        var moveBack = CCActionEaseBounceOut(action: move.reverse())
        var shakeSequence = CCActionSequence(array: [move, moveBack])
        var bullet = CCBReader.load("Effects and Projectiles/ccbFiles/BigMissle")
        bullet.physicsBody.collisionType = "enemyBullet"
        bullet.physicsBody.sensor = true
        bullet.position = ccp(position.x - contentSizeInPoints.width * 0.2 * CGFloat(scale), position.y - contentSizeInPoints.height * 0.2 * CGFloat(scale))
        bullet.scale = 1
        bullet.zOrder = 10
        bullet.scaleX = -1
        parent.addChild(bullet)
        bullet.physicsBody.applyImpulse(ccp(-50,CGFloat(10 * CCRANDOM_MINUS1_1())))
        projectiles.append(bullet)
    }
    
}
