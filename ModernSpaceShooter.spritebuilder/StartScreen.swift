
//
//  StartScreen.swift
//  ModernSpaceShooter
//
//  Created by Gagandeep Sawhney on 8/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//
import GameKit
import UIKit
import GoogleMobileAds

class StartScreen: CCNode {
    weak var bgMusicButton: CCButton!
    weak var sfxButton: CCButton!
    weak var hero1: CCSprite!
    weak var storeScroll: CCScrollView!
    var bgs: [CCSprite] = []
    weak var bg1: CCSprite!
    var hero: CCSprite!
    weak var bg2: CCSprite!
    var screenWidth = UIScreen.mainScreen().bounds.width
    var screenHeight = UIScreen.mainScreen().bounds.height
    var screenSize = UIScreen.mainScreen().bounds
    let view: UIViewController = CCDirector.sharedDirector().parentViewController! // Returns a UIView of the cocos2d view controller.
    weak var gamePhysicsNode: CCPhysicsNode!

    var playBool: Bool!
    func didLoadFromCCB(){
        setUpGameCenter()
        bgs.append(bg1)
        bgs.append(bg2)
    }
    func bgMusic() {
        OALSimpleAudio.sharedInstance().bgMuted = !OALSimpleAudio.sharedInstance().bgMuted
    }
    func sfx() {
        OALSimpleAudio.sharedInstance().effectsMuted = !OALSimpleAudio.sharedInstance().effectsMuted
    }
    func setUpGameCenter() {
        GameCenterHelper.sharedInstance.authenticationCheck()
    }
    override func onEnter() {
        var tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIScreenName, value: "Home")
        var builder = GAIDictionaryBuilder.createScreenView()
        tracker.send(builder.build() as [NSObject : AnyObject])
        super.onEnter()
        playBool = false
        if NSUserDefaults.standardUserDefaults().integerForKey("player") == 0 {
            NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "player")
        }
        var heroNum = NSUserDefaults.standardUserDefaults().integerForKey("player")
        hero = CCBReader.load("Player/ccbFiles/Player\(heroNum)") as! CCSprite
        hero.position = ccp(contentSizeInPoints.width * CGFloat(0.419) , contentSizeInPoints.height * CGFloat(0.608))
        hero.scale = 1
        gamePhysicsNode.addChild(hero)
        hero1.removeFromParent()
        
    }
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        if animationManager.runningSequenceName != nil {
            if animationManager.runningSequenceName == "Settings Timeline"  {
                animationManager.runAnimationsForSequenceNamed("GOAWAY Timeline")
            }
        }
    }

    func play() {
        playBool = true
        let scene = CCBReader.loadAsScene("MainScene")
        CCDirector.sharedDirector().presentScene(scene)
    }
    func store() {
        animationManager.runAnimationsForSequenceNamed("Store Timeline")
    }
    func back() {
        if storeScroll.scrollPosition.x < 20 {
            animationManager.runAnimationsForSequenceNamed("Back Timeline")
        }
        storeScroll.setScrollPosition(ccp(0,0), animated: true)
        
    }
    func settings() {
        if animationManager.runningSequenceName != "Settings Timeline" || animationManager.runningSequenceName == nil {
            animationManager.runAnimationsForSequenceNamed("Settings Timeline")
        }else {
            animationManager.runAnimationsForSequenceNamed("GOAWAY Timeline")
        }
    }
    func gameCenter() {
        showLeaderboard()
    }
    override func update(delta: CCTime) {
        var heroNum = NSUserDefaults.standardUserDefaults().integerForKey("player")
        if !playBool {
            bgMusicButton.selected = OALSimpleAudio.sharedInstance().bgMuted
            sfxButton.selected = OALSimpleAudio.sharedInstance().effectsMuted
            if heroNum == 1 {
                if !hero.isKindOfClass(Player1){
                    hero.removeFromParent()
                    var hero1 = CCBReader.load("Player/ccbFiles/Player\(heroNum)") as! CCSprite
                    hero1.position = ccp(contentSizeInPoints.width * CGFloat(0.419) , contentSizeInPoints.height * CGFloat(0.608))
                    hero1.scale = 1
                    gamePhysicsNode.addChild(hero)
                    hero = hero1
                }
            }
            if heroNum == 2 {
                if !hero.isKindOfClass(Player2){
                    hero.removeFromParent()
                    var hero1 = CCBReader.load("Player/ccbFiles/Player\(heroNum)") as! CCSprite
                    hero1.position = ccp(contentSizeInPoints.width * CGFloat(0.419) , contentSizeInPoints.height * CGFloat(0.608))
                    hero1.scale = 1
                    gamePhysicsNode.addChild(hero)
                    hero = hero1
                }
            }
            if heroNum == 3 {
                if !hero.isKindOfClass(Player3){
                    hero.removeFromParent()
                    var hero1 = CCBReader.load("Player/ccbFiles/Player\(heroNum)") as! CCSprite
                    hero1.position = ccp(contentSizeInPoints.width * CGFloat(0.419) , contentSizeInPoints.height * CGFloat(0.608))
                    hero1.scale = 1
                    gamePhysicsNode.addChild(hero)
                    hero = hero1
                }
            }
            if heroNum == 4 {
                if !hero.isKindOfClass(Player4){
                    hero.removeFromParent()
                    var hero1 = CCBReader.load("Player/ccbFiles/Player\(heroNum)") as! CCSprite
                    hero1.position = ccp(contentSizeInPoints.width * CGFloat(0.419) , contentSizeInPoints.height * CGFloat(0.608))
                    hero1.scale = 1
                    gamePhysicsNode.addChild(hero)
                    hero = hero1
                }
            }
            for projectile in projectiles {
                // get the world position of the ground
                let projectileWorldPosition = gamePhysicsNode.convertToWorldSpace(projectile.position)
                // get the screen position of the ground
                let projectileScreenPosition = convertToNodeSpace(projectileWorldPosition)
                // if the left corner is one complete width off the screen, move it to the right
                if projectileScreenPosition.x <= (-projectile.contentSize.width * CGFloat(projectile.scaleX)) {
                    projectiles.removeAtIndex(find(projectiles, projectile)!)
                    projectile.removeFromParentAndCleanup(true)
                }
                if projectileScreenPosition.x >= (contentSizeInPoints.width + projectile.contentSize.width * CGFloat(projectile.scaleX)) {
                    projectiles.removeAtIndex(find(projectiles, projectile)!)
                    projectile.removeFromParentAndCleanup(true)
                }
            }
            // clamp physics node and hero position to the next nearest pixel value to avoid black line artifacts
            let scale = CCDirector.sharedDirector().contentScaleFactor
            
            
            for ground in bgs {
                // get the world position of the ground
                let groundWorldPosition = gamePhysicsNode.convertToWorldSpace(ground.position)
                // get the screen position of the ground
                let groundScreenPosition = convertToNodeSpace(groundWorldPosition)
                // if the left corner is one complete width off the screen, move it to the right
                if groundScreenPosition.x <= (-ground.contentSize.width * CGFloat(ground.scaleX)) {
                    ground.position = ccp(ground.position.x + ground.contentSize.width * 2 * CGFloat(ground.scaleX), ground.position.y)
                }
                else {
                    ground.position = ccp(ground.position.x - 125 * CGFloat(delta), ground.position.y)
                    
                }
                ground.position = ccp(round(ground.position.x * scale) / scale, round(ground.position.y * scale) / scale)
                
            }
        }
    }
}
extension StartScreen: GKGameCenterControllerDelegate {
    
    
    
    func showLeaderboard() {
        
        var viewController = CCDirector.sharedDirector().parentViewController!
        var gameCenterViewController = GKGameCenterViewController()
        gameCenterViewController.gameCenterDelegate = self
        viewController.presentViewController(gameCenterViewController, animated: true, completion: nil)
        
    }
    
    // Delegate methods
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController!) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
