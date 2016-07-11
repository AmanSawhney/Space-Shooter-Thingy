
//
//  Health.swift
//  ModernSpaceShooter
//
//  Created by Gagandeep Sawhney on 8/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.    //

import UIKit

class Health: CCNode {
    func didLoadFromCCB() {
        schedule("updateHealth", interval: 3)
        schedualed = false
    }
    func updateHealth() {
        if playerHealth < 10 {
            playerHealth = playerHealth + 1
        }
    }
    weak var heart1: CCSprite!
    weak var heart2: CCSprite!
    weak var heart3: CCSprite!
    weak var heart4: CCSprite!
    weak var heart5: CCSprite!
    weak var heart6: CCSprite!
    weak var heart7: CCSprite!
    weak var heart8: CCSprite!
    weak var heart9: CCSprite!
    weak var heart10: CCSprite!
    var schedualed: Bool!
    override func update(delta: CCTime) {
        if playerHealth < 10 {
            heart1.spriteFrame = CCSpriteFrame(imageNamed: "Heads-up Display/EmptyHeart.png")
            
        }else {
            heart1.spriteFrame = CCSpriteFrame(imageNamed: "Heads-up Display/Heart.png")
        }
        if playerHealth < 9 {
            heart2.spriteFrame = CCSpriteFrame(imageNamed: "Heads-up Display/EmptyHeart.png")
            
        }else {
            heart2.spriteFrame = CCSpriteFrame(imageNamed: "Heads-up Display/Heart.png")
        }
        if playerHealth < 8 {
            heart3.spriteFrame = CCSpriteFrame(imageNamed: "Heads-up Display/EmptyHeart.png")
            
        }else {
            heart3.spriteFrame = CCSpriteFrame(imageNamed: "Heads-up Display/Heart.png")
        }
        if playerHealth < 7 {
            heart4.spriteFrame = CCSpriteFrame(imageNamed: "Heads-up Display/EmptyHeart.png")
            
        }else {
            heart4.spriteFrame = CCSpriteFrame(imageNamed: "Heads-up Display/Heart.png")
        }
        if playerHealth < 6 {
            heart5.spriteFrame = CCSpriteFrame(imageNamed: "Heads-up Display/EmptyHeart.png")
            
        }else {
            heart5.spriteFrame = CCSpriteFrame(imageNamed: "Heads-up Display/Heart.png")
        }
        if playerHealth < 5 {
            heart6.spriteFrame = CCSpriteFrame(imageNamed: "Heads-up Display/EmptyHeart.png")
            
        }else {
            heart6.spriteFrame = CCSpriteFrame(imageNamed: "Heads-up Display/Heart.png")
        }
        if playerHealth < 4 {
            heart7.spriteFrame = CCSpriteFrame(imageNamed: "Heads-up Display/EmptyHeart.png")
            
        }else {
            heart7.spriteFrame = CCSpriteFrame(imageNamed: "Heads-up Display/Heart.png")
        }
        if playerHealth < 3 {
            heart8.spriteFrame = CCSpriteFrame(imageNamed: "Heads-up Display/EmptyHeart.png")
            
        }else {
            heart8.spriteFrame = CCSpriteFrame(imageNamed: "Heads-up Display/Heart.png")
        }
        if playerHealth < 2 {
            heart9.spriteFrame = CCSpriteFrame(imageNamed: "Heads-up Display/EmptyHeart.png")
            
        }else {
            heart9.spriteFrame = CCSpriteFrame(imageNamed: "Heads-up Display/Heart.png")
        }
        if playerHealth < 1 {
            heart10.spriteFrame = CCSpriteFrame(imageNamed: "Heads-up Display/EmptyHeart.png")
            
        }else {
            heart10.spriteFrame = CCSpriteFrame(imageNamed: "Heads-up Display/Heart.png")
        }
        if playerHealth == 0 {
            if !schedualed {
                unschedule("updateHealth")
                schedualed = true
            }
            
        }
        
    }
}
