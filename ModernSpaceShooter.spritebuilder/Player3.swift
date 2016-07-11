//
//  Player1.swift
//  ModernSpaceShooter
//
//  Created by Gagandeep Sawhney on 8/19/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit

class Player3: CCSprite {
    func didLoadFromCCB() {
        physicsBody.sensor = true
        playerHealth = 10
    }
    
    override func onEnter() {
        super.onEnter()
        schedule("shoot", interval: 0.3)
        schedule("shoot1", interval: 0.55)
        schedule("shoot2", interval: 0.43)
        schedule("shoot3", interval: 0.59)
        schedule("shoot4", interval: 0.41)
        schedule("shoot5", interval: 0.59)
        schedule("shoot6", interval: 0.41)
        
        
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
    func shoot1() {
        var bullet = CCBReader.load("Effects and Projectiles/ccbFiles/YellowLaser")
        bullet.physicsBody.collisionType = "playerBullet"
        bullet.physicsBody.sensor = true
        bullet.position = ccp(positionInPoints.x + contentSizeInPoints.width * CGFloat(scale * 0.15), positionInPoints.y + contentSizeInPoints.height *  2 * 0.28 * CGFloat(scale))
        bullet.scale = scale * 0.5
        bullet.zOrder = 10
        parent.addChild(bullet)
        bullet.physicsBody.velocity.x = 300
        if bullet.position.x > position.x + parent.contentSizeInPoints.width {
            bullet.removeFromParentAndCleanup(true)
        }
        projectiles.append(bullet)
    }
    func shoot2() {
        var bullet = CCBReader.load("Effects and Projectiles/ccbFiles/YellowLaser")
        bullet.physicsBody.collisionType = "playerBullet"
        bullet.physicsBody.sensor = true
        bullet.position = ccp(positionInPoints.x + contentSizeInPoints.width * CGFloat(scale * 0.2), positionInPoints.y + contentSizeInPoints.height *  2 * 0.28 * CGFloat(scale))
        bullet.scale = scale * 0.5
        bullet.zOrder = 10
        parent.addChild(bullet)
        bullet.physicsBody.velocity.x = 300
        if bullet.position.x > position.x + parent.contentSizeInPoints.width {
            bullet.removeFromParentAndCleanup(true)
        }
        projectiles.append(bullet)
    }
    func shoot3() {
        var bullet = CCBReader.load("Effects and Projectiles/ccbFiles/YellowLaser")
        bullet.physicsBody.collisionType = "playerBullet"
        bullet.physicsBody.sensor = true
        bullet.position = ccp(positionInPoints.x + contentSizeInPoints.width * CGFloat(scale * 0.3), positionInPoints.y + contentSizeInPoints.height *  2 * 0.28 * CGFloat(scale))
        bullet.scale = scale * 0.5
        bullet.zOrder = 10
        parent.addChild(bullet)
        bullet.physicsBody.velocity.x = 300
        if bullet.position.x > position.x + parent.contentSizeInPoints.width {
            bullet.removeFromParentAndCleanup(true)
        }
        projectiles.append(bullet)
    }
    func shoot4() {
        var bullet = CCBReader.load("Effects and Projectiles/ccbFiles/YellowLaser")
        bullet.physicsBody.collisionType = "playerBullet"
        bullet.physicsBody.sensor = true
        bullet.position = ccp(positionInPoints.x + contentSizeInPoints.width * CGFloat(scale * 0.15), positionInPoints.y + contentSizeInPoints.height *  2 * 0.35 * CGFloat(scale))
        bullet.scale = scale * 0.5
        bullet.zOrder = 10
        parent.addChild(bullet)
        bullet.physicsBody.velocity.x = 300
        if bullet.position.x > position.x + parent.contentSizeInPoints.width {
            bullet.removeFromParentAndCleanup(true)
        }
        projectiles.append(bullet)
    }
    
    func shoot5() {
        var bullet = CCBReader.load("Effects and Projectiles/ccbFiles/YellowLaser")
        bullet.physicsBody.collisionType = "playerBullet"
        bullet.physicsBody.sensor = true
        bullet.position = ccp(positionInPoints.x + contentSizeInPoints.width * CGFloat(scale * 0.2), positionInPoints.y + contentSizeInPoints.height *  2 * 0.35 * CGFloat(scale))
        bullet.scale = scale * 0.5
        bullet.zOrder = 10
        parent.addChild(bullet)
        bullet.physicsBody.velocity.x = 300
        if bullet.position.x > position.x + parent.contentSizeInPoints.width {
            bullet.removeFromParentAndCleanup(true)
        }
        projectiles.append(bullet)
    }
    
    func shoot6() {
        var bullet = CCBReader.load("Effects and Projectiles/ccbFiles/YellowLaser")
        bullet.physicsBody.collisionType = "playerBullet"
        bullet.physicsBody.sensor = true
        bullet.position = ccp(positionInPoints.x + contentSizeInPoints.width * CGFloat(scale * 0.3), positionInPoints.y + contentSizeInPoints.height * 2 * 0.35 * CGFloat(scale))
        bullet.scale = scale * 0.5
        bullet.zOrder = 10
        parent.addChild(bullet)
        bullet.physicsBody.velocity.x = 300
        if bullet.position.x > position.x + parent.contentSizeInPoints.width {
            bullet.removeFromParentAndCleanup(true)
        }
        projectiles.append(bullet)
    }
    
    
}
