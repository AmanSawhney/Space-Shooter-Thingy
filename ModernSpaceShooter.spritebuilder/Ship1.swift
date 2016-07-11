//
//  Ship1.swift
//  ModernSpaceShooter
//
//  Created by Gagandeep Sawhney on 8/11/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit

class Ship1: Enemies {
    func didLoadFromCCB() {
        super.health = 1
        super.multiplier = 2
        physicsBody.sensor = true
        schedule("randomHeight", interval: 1)
        schedule("shoot1", interval: 1)
        schedule("shoot2", interval: 2)
        schedule("shoot3", interval: 3)
        schedule("shoot4", interval: 1.3)
        schedule("shoot5", interval: 2.3)
        schedule("shoot6", interval: 3.3)
        schedule("shoot7", interval: 1.7)
        schedule("shoot8", interval: 2.7)
        var action = CCActionMoveTo(duration: CCTime(1), position: ccp( (self.contentSizeInPoints.width * 10 + position.x), position.y))
        runAction(action)
    }
    func randomHeight() {
        physicsBody.velocity.y = CGFloat(Float(arc4random_uniform(50)) * CCRANDOM_MINUS1_1())
        
    }
    func shoot1() {
        var move = CCActionEaseBounceOut(action: CCActionMoveBy(duration: 0.1, position: ccp( ((contentSize.width)/200), 0)))
        var moveBack = CCActionEaseBounceOut(action: move.reverse())
        var shakeSequence = CCActionSequence(array: [move, moveBack])
        runAction(shakeSequence)
        var bullet = CCBReader.load("Effects and Projectiles/ccbFiles/TinyMissle")
        bullet.physicsBody.collisionType = "enemyBullet"
        bullet.physicsBody.sensor = true
        bullet.position = ccp(position.x + contentSizeInPoints.width * 0.05 * CGFloat(scale), position.y + contentSizeInPoints.height * 0.3 * CGFloat(scale))
        bullet.scale = 1
        bullet.zOrder = 10
        bullet.scaleX = -1
        parent.addChild(bullet)
        bullet.physicsBody.applyImpulse(ccp(-20,CGFloat(10 * CCRANDOM_MINUS1_1())))
        projectiles.append(bullet)
    }
    func shoot2() {
        var move = CCActionEaseBounceOut(action: CCActionMoveBy(duration: 0.1, position: ccp( ((contentSize.width)/200), 0)))
        var moveBack = CCActionEaseBounceOut(action: move.reverse())
        var shakeSequence = CCActionSequence(array: [move, moveBack])
        var bullet = CCBReader.load("Effects and Projectiles/ccbFiles/TinyMissle")
        bullet.physicsBody.collisionType = "enemyBullet"
        bullet.physicsBody.sensor = true
        bullet.position = ccp(position.x + contentSizeInPoints.width * 0.05 * CGFloat(scale), position.y + contentSizeInPoints.height * 0.2 * CGFloat(scale))
        bullet.scale = 1
        bullet.zOrder = 10
        bullet.scaleX = -1
        parent.addChild(bullet)
        bullet.physicsBody.applyImpulse(ccp(-20,CGFloat(10 * CCRANDOM_MINUS1_1())))
        projectiles.append(bullet)
    }
    func shoot3() {
        var move = CCActionEaseBounceOut(action: CCActionMoveBy(duration: 0.1, position: ccp( ((contentSize.width)/200), 0)))
        var moveBack = CCActionEaseBounceOut(action: move.reverse())
        var shakeSequence = CCActionSequence(array: [move, moveBack])
        var bullet = CCBReader.load("Effects and Projectiles/ccbFiles/TinyMissle")
        bullet.physicsBody.collisionType = "enemyBullet"
        bullet.physicsBody.sensor = true
        bullet.position = ccp(position.x + contentSizeInPoints.width * 0.05 * CGFloat(scale), position.y + contentSizeInPoints.height * 0.3 * CGFloat(scale))
        bullet.scale = 1
        bullet.zOrder = 10
        bullet.scaleX = -1
        parent.addChild(bullet)
        bullet.physicsBody.applyImpulse(ccp(-20,CGFloat(10 * CCRANDOM_MINUS1_1())))
        projectiles.append(bullet)
    }
    func shoot4() {
        var move = CCActionEaseBounceOut(action: CCActionMoveBy(duration: 0.1, position: ccp( ((contentSize.width)/200), 0)))
        var moveBack = CCActionEaseBounceOut(action: move.reverse())
        var shakeSequence = CCActionSequence(array: [move, moveBack])
        var bullet = CCBReader.load("Effects and Projectiles/ccbFiles/TinyMissle")
        bullet.physicsBody.collisionType = "enemyBullet"
        bullet.physicsBody.sensor = true
        bullet.position = ccp(position.x + contentSizeInPoints.width * 0.05 * CGFloat(scale), position.y + contentSizeInPoints.height * 0.2 * CGFloat(scale))
        bullet.scale = 1
        bullet.zOrder = 10
        bullet.scaleX = -1
        parent.addChild(bullet)
        bullet.physicsBody.applyImpulse(ccp(-20,CGFloat(10 * CCRANDOM_MINUS1_1())))
        projectiles.append(bullet)
    }
    func shoot5() {
        var move = CCActionEaseBounceOut(action: CCActionMoveBy(duration: 0.1, position: ccp( ((contentSize.width)/200), 0)))
        var moveBack = CCActionEaseBounceOut(action: move.reverse())
        var shakeSequence = CCActionSequence(array: [move, moveBack])
        var bullet = CCBReader.load("Effects and Projectiles/ccbFiles/TinyMissle")
        bullet.physicsBody.collisionType = "enemyBullet"
        bullet.physicsBody.sensor = true
        bullet.position = ccp(position.x, position.y - contentSizeInPoints.height * 0.3 * CGFloat(scale))
        bullet.scale = 1
        bullet.zOrder = 10
        bullet.scaleX = -1
        parent.addChild(bullet)
        bullet.physicsBody.applyImpulse(ccp(-20,CGFloat(10 * CCRANDOM_MINUS1_1())))
        projectiles.append(bullet)
    }
    func shoot6() {
        var move = CCActionEaseBounceOut(action: CCActionMoveBy(duration: 0.1, position: ccp( ((contentSize.width)/200), 0)))
        var moveBack = CCActionEaseBounceOut(action: move.reverse())
        var shakeSequence = CCActionSequence(array: [move, moveBack])
        var bullet = CCBReader.load("Effects and Projectiles/ccbFiles/TinyMissle")
        bullet.physicsBody.collisionType = "enemyBullet"
        bullet.physicsBody.sensor = true
        bullet.position = ccp(position.x, position.y - contentSizeInPoints.height * 0.2 * CGFloat(scale))
        bullet.scale = 1
        bullet.zOrder = 10
        bullet.scaleX = -1
        parent.addChild(bullet)
        bullet.physicsBody.applyImpulse(ccp(-20,CGFloat(10 * CCRANDOM_MINUS1_1())))
        projectiles.append(bullet)
    }
    func shoot7() {
        var move = CCActionEaseBounceOut(action: CCActionMoveBy(duration: 0.1, position: ccp( ((contentSize.width)/200), 0)))
        var moveBack = CCActionEaseBounceOut(action: move.reverse())
        var shakeSequence = CCActionSequence(array: [move, moveBack])
        var bullet = CCBReader.load("Effects and Projectiles/ccbFiles/TinyMissle")
        bullet.physicsBody.collisionType = "enemyBullet"
        bullet.physicsBody.sensor = true
        bullet.position = ccp(position.x, position.y - contentSizeInPoints.height * 0.3 * CGFloat(scale))
        bullet.scale = 1
        bullet.zOrder = 10
        bullet.scaleX = -1
        parent.addChild(bullet)
        bullet.physicsBody.applyImpulse(ccp(-20,CGFloat(10 * CCRANDOM_MINUS1_1())))
        projectiles.append(bullet)
    }
    func shoot8() {
        var move = CCActionEaseBounceOut(action: CCActionMoveBy(duration: 0.1, position: ccp( ((contentSize.width)/200), 0)))
        var moveBack = CCActionEaseBounceOut(action: move.reverse())
        var shakeSequence = CCActionSequence(array: [move, moveBack])
        var bullet = CCBReader.load("Effects and Projectiles/ccbFiles/TinyMissle")
        bullet.physicsBody.collisionType = "enemyBullet"
        bullet.physicsBody.sensor = true
        bullet.position = ccp(position.x, position.y - contentSizeInPoints.height * 0.2 * CGFloat(scale))
        bullet.scale = 1
        bullet.zOrder = 10
        bullet.scaleX = -1
        parent.addChild(bullet)
        bullet.physicsBody.applyImpulse(ccp(-20,CGFloat(10 * CCRANDOM_MINUS1_1())))
        projectiles.append(bullet)
    }
    
    
    
}
