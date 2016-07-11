
//
//  Ship3.swift
//  ModernSpaceShooter
//
//  Created by Gagandeep Sawhney on 8/13/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit

class Ship3: Enemies {
    func didLoadFromCCB() {
        super.health = 2
        super.multiplier = 4
        var action = CCActionMoveTo(duration: CCTime(1), position: ccp( (self.contentSizeInPoints.width * 2 + position.x), position.y))
        runAction(action)
        var screenWidth = UIScreen.mainScreen().bounds.width
        var screenHeight = UIScreen.mainScreen().bounds.height
        physicsBody.sensor = true
        schedule("randomHeight", interval: 1)
        schedule("shoot1", interval: 1.4)
        schedule("shoot2", interval: 0.94)
        schedule("shoot3", interval: 0.45)
        schedule("shoot4", interval: 1)
        schedule("shoot5", interval: 1.1)
    }
    func randomHeight() {
        physicsBody.velocity.y = CGFloat(Float(arc4random_uniform(50)) * CCRANDOM_MINUS1_1())
        
    }
    func shoot1() {
        var bullet = CCBReader.load("Effects and Projectiles/ccbFiles/BlueLaser")
        bullet.physicsBody.collisionType = "enemyBullet"
        bullet.physicsBody.sensor = true
        bullet.position = ccp(position.x + contentSizeInPoints.width * 0.15  * CGFloat(scale), position.y - contentSizeInPoints.height * 0.25  * CGFloat(scale))
        bullet.scale = 1
        bullet.zOrder = 10
        bullet.scaleX = -1
        parent.addChild(bullet)
        bullet.physicsBody.applyImpulse(ccp(-200,CGFloat(10 * CCRANDOM_MINUS1_1())))
        projectiles.append(bullet)
        var move = CCActionEaseBounceOut(action: CCActionMoveBy(duration: 0.1, position: ccp( ((contentSize.width)/50), 0)))
        var moveBack = CCActionEaseBounceOut(action: move.reverse())
        var shakeSequence = CCActionSequence(array: [move, moveBack])
    }
    func shoot2() {
        var bullet = CCBReader.load("Effects and Projectiles/ccbFiles/TinyMissle")
        bullet.physicsBody.collisionType = "enemyBullet"
        bullet.physicsBody.sensor = true
        bullet.position = ccp(position.x - contentSizeInPoints.width * 0.37  * CGFloat(scale), position.y - contentSizeInPoints.height * 0.22  * CGFloat(scale))
        bullet.scale = 1
        bullet.zOrder = 10
        bullet.scaleX = -1
        parent.addChild(bullet)
        bullet.physicsBody.applyImpulse(ccp(-20,CGFloat(10 * CCRANDOM_MINUS1_1())))
        projectiles.append(bullet)
        var move = CCActionEaseBounceOut(action: CCActionMoveBy(duration: 0.1, position: ccp( ((contentSize.width)/200), 0)))
        var moveBack = CCActionEaseBounceOut(action: move.reverse())
        var shakeSequence = CCActionSequence(array: [move, moveBack])
    }
    func shoot3() {
        var bullet = CCBReader.load("Effects and Projectiles/ccbFiles/TinyMissle")
        bullet.physicsBody.collisionType = "enemyBullet"
        bullet.physicsBody.sensor = true
        bullet.position = ccp(position.x - contentSizeInPoints.width * 0.27 * CGFloat(scale), position.y - contentSizeInPoints.height * 0.22 * CGFloat(scale))
        bullet.scale = 1
        bullet.zOrder = 10
        bullet.scaleX = -1
        parent.addChild(bullet)
        bullet.physicsBody.applyImpulse(ccp(-20,CGFloat(10 * CCRANDOM_MINUS1_1())))
        projectiles.append(bullet)
        var move = CCActionEaseBounceOut(action: CCActionMoveBy(duration: 0.1, position: ccp( ((contentSize.width)/200), 0)))
        var moveBack = CCActionEaseBounceOut(action: move.reverse())
        var shakeSequence = CCActionSequence(array: [move, moveBack])
    }
    func shoot4() {
        var bullet = CCBReader.load("Effects and Projectiles/ccbFiles/TinyMissle")
        bullet.physicsBody.collisionType = "enemyBullet"
        bullet.physicsBody.sensor = true
        bullet.position = ccp(position.x - contentSizeInPoints.width * 0.28 * CGFloat(scale), position.y - contentSizeInPoints.height * 0.18 * CGFloat(scale))
        bullet.scale = 1
        bullet.zOrder = 10
        bullet.scaleX = -1
        parent.addChild(bullet)
        bullet.physicsBody.applyImpulse(ccp(-20,CGFloat(10 * CCRANDOM_MINUS1_1())))
        projectiles.append(bullet)
        var move = CCActionEaseBounceOut(action: CCActionMoveBy(duration: 0.1, position: ccp( ((contentSize.width)/200), 0)))
        var moveBack = CCActionEaseBounceOut(action: move.reverse())
        var shakeSequence = CCActionSequence(array: [move, moveBack])
    }
    func shoot5() {
        var bullet = CCBReader.load("Effects and Projectiles/ccbFiles/TinyMissle")
        bullet.physicsBody.collisionType = "enemyBullet"
        bullet.physicsBody.sensor = true
        bullet.position = ccp(position.x - contentSizeInPoints.width * 0.38 * CGFloat(scale), position.y - contentSizeInPoints.height * 0.18 * CGFloat(scale))
        bullet.scale = 1
        bullet.zOrder = 10
        bullet.scaleX = -1
        parent.addChild(bullet)
        bullet.physicsBody.applyImpulse(ccp(-20,CGFloat(10 * CCRANDOM_MINUS1_1())))
        projectiles.append(bullet)
        var move = CCActionEaseBounceOut(action: CCActionMoveBy(duration: 0.1, position: ccp( ((contentSize.width)/200), 0)))
        var moveBack = CCActionEaseBounceOut(action: move.reverse())
        var shakeSequence = CCActionSequence(array: [move, moveBack])
    }
    
}
