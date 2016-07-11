import Foundation
import GoogleMobileAds
import StoreKit
import GameKit

var projectiles: [CCNode] = []
var shells: [CCNode] = []
var score: Int!
var enemies: [Enemies] = []
class MainScene: CCNode, CCPhysicsCollisionDelegate, ChartboostDelegate {
    var startAppAd: STAStartAppAd?
    weak var hand: CCSprite!
    var playBool: Bool!
    var interstitial: GADInterstitial?
    var bgs: [CCSprite] = []
    weak var bg1: CCSprite!
    weak var moon: CCSprite!
    weak var bg2: CCSprite!
    var scrollSpeed: CGFloat = 300
    var sinceTouch: CCTime = 0
    var screenWidth = UIScreen.mainScreen().bounds.width
    var screenHeight = UIScreen.mainScreen().bounds.height
    var isGameOver = false {
        didSet {
            var scoreReporter = GKScore(leaderboardIdentifier: "SinglePlayerLeaderBoard")
            scoreReporter.value = Int64(NSUserDefaults.standardUserDefaults().integerForKey("highscore"))
        }
    }
    weak var hero1: CCSprite!
    weak var gamePhysicsNode: CCPhysicsNode!
    var buildingLayerArray: [CCNode] = []
    weak var ground1: CCSprite!
    weak var ground2: CCSprite!
    var interval: Double!
    var currentTouchLocation: CGPoint!
    var hero: CCSprite!
    var grounds: [CCSprite] = []  // initializes an empty array
    var screenSize = UIScreen.mainScreen().bounds
    let view: UIViewController = CCDirector.sharedDirector().parentViewController! // Returns a UIView of the cocos2d view controller.
    func didLoadFromCCB() {
        
    }
    
    func setUpGameCenter() {
        GameCenterHelper.sharedInstance.authenticationCheck()
    }
    override func onEnter() {
        super.onEnter()
        startAppAd = STAStartAppAd()
        startAppAd!.loadAd()
        var tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIScreenName, value: "Play")
        var builder = GAIDictionaryBuilder.createScreenView()
        tracker.send(builder.build() as [NSObject : AnyObject])
        let kChartboostAppID = "5472ef8f04b01601a1a5814c";
        let kChartboostAppSignature = "5b6222426e68cda48669a1d4d8246d4c3d20db9c";
        Chartboost.startWithAppId(kChartboostAppID, appSignature: kChartboostAppSignature, delegate: self);
        score = 0
        //gamePhysicsNode.debugDraw = true
        bgs.append(bg1)
        bgs.append(bg2)
        var layer1 = randomLayer()
        buildingLayerArray.append(layer1)
        layer1.zOrder = -11
        gamePhysicsNode.addChild(layer1)
        var layer2 = randomLayer()
        layer2.position.x = layer2.contentSizeInPoints.width
        layer2.zOrder = -10
        buildingLayerArray.append(layer2)
        gamePhysicsNode.addChild(layer2)
        gamePhysicsNode.collisionDelegate = self
        userInteractionEnabled = true
        grounds.append(ground1)
        grounds.append(ground2)
        interval = 0.32
        schedule("spawnEnemy", interval: 0.32)
        if NSUserDefaults.standardUserDefaults().integerForKey("player") == 0 {
            NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "player")
        }
        var heroNum = NSUserDefaults.standardUserDefaults().integerForKey("player")
        hero = CCBReader.load("Player/ccbFiles/Player\(heroNum)") as! CCSprite
        hero.positionInPoints = hero1.positionInPoints
        hero.scale = 0.5
        gamePhysicsNode.addChild(hero)
        hero1.removeFromParent()
        setUpGameCenter()
        Chartboost.cacheRewardedVideo(CBLocationItemStore)
        Chartboost.cacheInterstitial(CBLocationGameOver)
        playBool = false
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-4509898719172538/9441229007")
        var request = GADRequest()
        interstitial!.loadRequest(request)
    }
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, hero : CCNode!, enemyBullet : CCNode!) -> Bool {
        var getHit = CCBReader.load("Effects and Projectiles/ccbFiles/GetHit")
        if hero != nil {
            if getHit != nil {
                getHit.scale = Float(Double(hero.contentSize.width)/200)
                getHit.rotation = Float(arc4random_uniform(360))
                gamePhysicsNode.addChild(getHit)
            }
            getHit.position = enemyBullet.position
            enemyBullet.removeFromParent()
            
        }
        if playerHealth == 0 {
            gameOver()
        }
        playerHealth = playerHealth - 1
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        return true
    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, hero : CCNode!, enemy : CCNode!) -> Bool {
        var getHit = CCBReader.load("Effects and Projectiles/ccbFiles/GetHit")
        if hero != nil {
            if getHit != nil {
                getHit.scale = Float(Double(hero.contentSize.width)/200)
                getHit.rotation = Float(arc4random_uniform(360))
                gamePhysicsNode.addChild(getHit)
            }
            getHit.position = enemy.position
            
        }
        playerHealth = playerHealth - 1
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        if playerHealth == 0 {
            gameOver()
        }
        
        
        return true
        
    }
    func ads() {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "ads")
        var ads = NSUserDefaults.standardUserDefaults().boolForKey("ads")
        if !ads {
            if startAppAd!.isReady() {
                startAppAd!.showAd()
            }else {
                interstitial!.presentFromRootViewController(view)
            }
        }
    }
    
    func ccPhysicsCollisionSeparate(pair: CCPhysicsCollisionPair!, coin: CCNode!, hero: CCNode!) {
        if coin.animationManager.runningSequenceName != "Coin Timeline" {
            coin.animationManager.runAnimationsForSequenceNamed("Coin Timeline")
            var coins = NSUserDefaults.standardUserDefaults().integerForKey("coins")
            coins++
            NSUserDefaults.standardUserDefaults().setInteger(coins, forKey: "coins")
        }
        
    }
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, hero nodeA: CCNode!, ground nodeB: CCNode!) -> Bool {
        gameOver()
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        return true
    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!,  playerBullet: CCNode!,  enemy: Enemies!) -> Bool {
        if isGameOver == false {
            playerBullet.removeFromParentAndCleanup(true)
            if enemy != nil {
                if enemy.health != nil  {
                    enemy.health =  enemy.health - 1
                }
                if enemy.health > 0 {
                    var getHit = CCBReader.load("Effects and Projectiles/ccbFiles/GetHit")
                    getHit.scale = Float(Double(enemy.contentSize.width)/100)
                    getHit.rotation = Float(arc4random_uniform(360))
                    gamePhysicsNode.addChild(getHit)
                    getHit.position = playerBullet.position
                    projectiles.append(getHit)
                    
                }
                if enemy.health == 0 || enemy.health == nil{
                    if interval > 0.115 {
                        interval = interval * 0.9925
                    }
                    if scrollSpeed < 450 {
                        scrollSpeed += 2
                    }
                    unschedule("spawnEnemy")
                    schedule("spawnEnemy", interval: interval)
                    var random = CCRANDOM_0_1()
                    if random < 1/3 {
                        var coin = CCBReader.load("Heads-up Display/Coin")
                        coin.scale = 0.5
                        coin.position = enemy.position
                        gamePhysicsNode.addChild(coin)
                        projectiles.append(coin)
                    }
                    score = score + ((Int(enemy.contentSizeInPoints.width * CGFloat(enemy.scale * 2)) + Int(enemy.contentSizeInPoints.height * CGFloat(enemy.scale * 2))) * enemy.multiplier)/10
                    var label = CCBReader.load("Heads-up Display/AmountAdded") as! EnemyPointLabel!
                    label.label.string = "+ \(((Int(enemy.contentSizeInPoints.width * CGFloat(enemy.scale * 2)) + Int(enemy.contentSizeInPoints.height * CGFloat(enemy.scale * 2))) * enemy.multiplier)/10)"
                    label.position = enemy.position
                    label.zOrder = 1000
                    gamePhysicsNode.addChild(label)
                    var explosion = CCBReader.load("Effects and Projectiles/ccbFiles/Explosion")
                    if enemy != nil {
                        
                        if explosion != nil {
                            explosion.scale = Float(Double(enemy.contentSize.width)/200)
                            explosion.rotation = Float(arc4random_uniform(360))
                            gamePhysicsNode.addChild(explosion)
                            NSThread.sleepForTimeInterval(0.022)
                            projectiles.append(explosion)
                            
                            
                        }
                        var move = CCActionEaseBounceOut(action: CCActionMoveBy(duration: 0.1, position: ccp(0, (enemy.contentSize.width)/20)))
                        var moveBack = CCActionEaseBounceOut(action: move.reverse())
                        var move1 = CCActionEaseBounceOut(action: CCActionMoveBy(duration: 0.1, position: ccp(0, -(enemy.contentSize.width)/20)))
                        var moveBack1 = CCActionEaseBounceOut(action: move1.reverse())
                        var shakeSequence1 = CCActionSequence(array: [move, moveBack, move1, moveBack1])
                        gamePhysicsNode.runAction(shakeSequence1)
                        explosion.position = enemy.position
                        enemy.removeFromParent()
                    }
                    
                    
                }
                
            }
        }
        return true
    }
    func gameOver() {
        isGameOver = true
        let defaults = NSUserDefaults.standardUserDefaults()
        if (defaults.integerForKey("highscore")) < score {
            defaults.setInteger(score, forKey: "highscore")
        }
        var highScore = NSUserDefaults.standardUserDefaults().integerForKey("highscore")
        GameCenterHelper.sharedInstance.saveHighScore(Double(highScore))
        playerHealth = 0
        self.animationManager.runAnimationsForSequenceNamed("GameOver Timeline")
        unschedule("spawnEnemy")
        hero.unschedule("shoot")
        var explosion = CCBReader.load("Effects and Projectiles/ccbFiles/Explosion")
        if hero != nil {
            if explosion != nil {
                explosion.scale = Float(Double(hero.contentSize.width)/200)
                explosion.rotation = Float(arc4random_uniform(360))
                gamePhysicsNode.addChild(explosion)
            }
            explosion.position = hero.position
            hero.visible = false
            hero.position = ccp(1000,1000)
            var move = CCActionEaseBounceOut(action: CCActionMoveBy(duration: 0.1, position: ccp(0, (hero.contentSize.width)/2 )))
            var moveBack = CCActionEaseBounceOut(action: move.reverse())
            var move1 = CCActionEaseBounceOut(action: CCActionMoveBy(duration: 0.1, position: ccp(0, -(hero.contentSize.width)/2)))
            var moveBack1 = CCActionEaseBounceOut(action: move1.reverse())
            var shakeSequence1 = CCActionSequence(array: [move, moveBack, move1, moveBack1])
            gamePhysicsNode.runAction(shakeSequence1)
            
        }
        
    }
    
    func home() {
        playBool = true
        gamePhysicsNode.removeAllChildren()
        let scene = CCBReader.loadAsScene("StartScreen")
        CCDirector.sharedDirector().presentScene(scene)
    }
    
    func retry() {
        playBool = true
        gamePhysicsNode.removeAllChildren()
        let scene = CCBReader.loadAsScene("MainScene")
        CCDirector.sharedDirector().presentScene(scene)
    }
    func share() {
        Mixpanel.sharedInstance().track("Shared")
        let screenshot = self.takePresentScreenshot()
        let objectsToShare = [screenshot]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        if UIDevice.currentDevice().model != "iPad"{
            view.presentViewController(activityVC, animated: true, completion: nil)
        } else {
            
            var popup = UIPopoverController(contentViewController: activityVC)
            popup.presentPopoverFromRect(CGRectMake(screenSize.width/2, screenSize.height/4, 0, 0), inView: CCDirector.sharedDirector().view, permittedArrowDirections: UIPopoverArrowDirection.Unknown, animated: true)
            
        }
    }
    
    func watchForCoins() {
        if Chartboost.hasRewardedVideo(CBLocationItemStore) {
            Chartboost.showRewardedVideo(CBLocationItemStore)
            Chartboost.cacheRewardedVideo(CBLocationItemStore)
            var coins = NSUserDefaults.standardUserDefaults().integerForKey("coins")
            coins += 10
            NSUserDefaults.standardUserDefaults().setInteger(coins, forKey: "coins")
        } else {
            let alert = UIAlertView()
            alert.title = "OH NO!!!"
            alert.message = "Looks like the ads could not load!"
            alert.addButtonWithTitle("AWWWWW")
            alert.addButtonWithTitle("POOOOOO")
            alert.show()
        }
    }
    
    
    
    func takePresentScreenshot() -> UIImage {
        CCDirector.sharedDirector().nextDeltaTimeZero = true
        
        var size: CGSize = CCDirector.sharedDirector().viewSize()
        var renderTxture: CCRenderTexture = CCRenderTexture(width: Int32(size.width), height: Int32(size.height))
        renderTxture.begin()
        CCDirector.sharedDirector().runningScene.visit()
        renderTxture.end()
        
        return renderTxture.getUIImage()
    }
    
    func spawnEnemy() {
        let random = CCRANDOM_0_1()
        var randomHeight = arc4random_uniform(UInt32(contentSizeInPoints.height))
        if random < 0.25 {
            var cartype = Int(arc4random_uniform(3)) + 1
            if cartype > 3 {
                cartype = 3
            }
            var car = CCBReader.load("Enemys/ccbFiles/Ground/Ground\(cartype)") as! Enemies
            car.position = ccp(hero.position.x + screenWidth * 1.5, CGFloat(randomHeight))
            car.scale = 0.7
            enemies.append(car)
            gamePhysicsNode.addChild(car)
        } else {
            var shiptype = Int(arc4random_uniform(3)) + 1
            if shiptype > 3 {
                shiptype = 3
            }
            var ship = CCBReader.load("Enemys/ccbFiles/Ship/Ship\(shiptype)") as! Enemies
            ship.scale = CCRANDOM_0_1()
            if ship.scale < 0.3 {
                ship.scale = 0.4
            }
            if ship.scale > 0.6 {
                ship.scale = 0.6
            }
            randomHeight = arc4random_uniform(UInt32(contentSizeInPoints.height - ship.contentSize.height * CGFloat(ship.scale))) + UInt32(contentSizeInPoints.height/8)
            ship.physicsBody.sensor = true
            ship.position = ccp(hero.position.x + screenWidth * 1.5, CGFloat(randomHeight))
            gamePhysicsNode.addChild(ship)
            enemies.append(ship)
            ship.physicsBody.velocity.x = CGFloat(-20)
            
        }
    }
    
    func randomLayer() -> CCNode! {
        var layer = Int(arc4random_uniform(2)) + 1
        if layer >= 2 {
            layer = 2
        }
        var returnLayer = CCBReader.load("Tiles and Objects/BuildingLayers/BuildingLayer\(layer)")
        returnLayer.zOrder = -1
        return returnLayer
    }
    
    override func update(delta: CCTime) {
        if !playBool {
            
            
            if hero.position.y > contentSizeInPoints.height - 30 - hero.contentSizeInPoints.height/2 * CGFloat(hero.scale) {
                var move = CCActionMoveTo(duration: 0.1, position: ccp(hero.position.x, ((contentSizeInPoints.height - 30 - hero.contentSizeInPoints.height/2 * CGFloat(hero.scale))-1)))
                hero.runAction(move)
            }
            if playerHealth < 1 && isGameOver == false {
                isGameOver == true
                gameOver()
            }
            for shell in shells {
                // get the world position of the ground
                let shellWorldPosition = gamePhysicsNode.convertToWorldSpace(shell.position)
                // get the screen position of the ground
                let shellScreenPosition = convertToNodeSpace(shellWorldPosition)
                // if the left corner is one complete width off the screen, move it to the right
                if shellScreenPosition.x <= (-shell.contentSize.width * CGFloat(shell.scaleX)) {
                    shells.removeAtIndex(find(shells, shell)!)
                    shell.removeFromParentAndCleanup(true)
                }
                if shellScreenPosition.x >= (contentSizeInPoints.width + shell.contentSize.width * CGFloat(shell.scaleX)) {
                    shells.removeAtIndex(find(shells, shell)!)
                    shell.removeFromParentAndCleanup(true)
                }
                
            }
            for enemy in enemies {
                // get the world position of the ground
                let enemyWorldPosition = gamePhysicsNode.convertToWorldSpace(enemy.position)
                // get the screen position of the ground
                let enemyScreenPosition = convertToNodeSpace(enemyWorldPosition)
                // if the left corner is one complete width off the screen, move it to the right
                if enemyScreenPosition.x <= (-enemy.contentSize.width * CGFloat(enemy.scaleX)) {
                    enemies.removeAtIndex(find(enemies, enemy)!)
                    enemy.removeFromParentAndCleanup(true)
                }
            }
            //moon.position.x = moon.position.x + moon.contentSize.width * 2
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
                if projectile.physicsBody != nil {
                    if projectile.physicsBody.velocity.x < scrollSpeed * 2 && projectile.physicsBody.collisionType == "playerBullet" {
                        projectile.physicsBody.velocity.x = scrollSpeed * 2
                    }
                }
                
            }
            gamePhysicsNode.position = ccp(gamePhysicsNode.position.x - scrollSpeed * CGFloat(delta), gamePhysicsNode.position.y)
            hero.position = ccp(hero.position.x + scrollSpeed * CGFloat(delta), hero.position.y)
            
            // clamp physics node and hero position to the next nearest pixel value to avoid black line artifacts
            let scale = CCDirector.sharedDirector().contentScaleFactor
            hero.position = ccp(round(hero.position.x * scale) / scale, round(hero.position.y * scale) / scale)
            gamePhysicsNode.position = ccp(round(gamePhysicsNode.position.x * scale) / scale, round(gamePhysicsNode.position.y * scale) / scale)
            
            // loop the ground whenever a ground image was moved entirely outside the screen
            for ground in grounds {
                // get the world position of the ground
                let groundWorldPosition = gamePhysicsNode.convertToWorldSpace(ground.position)
                // get the screen position of the ground
                let groundScreenPosition = convertToNodeSpace(groundWorldPosition)
                // if the left corner is one complete width off the screen, move it to the right
                if groundScreenPosition.x <= (-ground.contentSize.width * CGFloat(ground.scaleX)) {
                    ground.position = ccp(ground.position.x + ground.contentSize.width * 2 * CGFloat(ground.scaleX), ground.position.y)
                }
            }
            for bg in bgs {
                if bg.position.x <= (-bg.contentSize.width * CGFloat(bg.scaleX)) {
                    bg.position = ccp(bg.position.x + bg.contentSize.width * 1.8 * CGFloat(bg.scaleX), bg.position.y)
                }
                else {
                    bg.position.x -= scrollSpeed/100
                }
            }
            for oldLayer in buildingLayerArray {
                let oldLayerWorldPosition = gamePhysicsNode.convertToWorldSpace(oldLayer.position)
                let oldLayerScreenPosition = convertToNodeSpace(oldLayerWorldPosition)
                if oldLayerScreenPosition.x <= (-oldLayer.contentSize.width) {
                    buildingLayerArray.removeAtIndex(find(buildingLayerArray, oldLayer)!)
                    var newLayer = randomLayer()
                    newLayer.zOrder = hero.zOrder - 5
                    newLayer.position = ccp(oldLayer.position.x + newLayer.contentSize.width * 2, newLayer.position.y)
                    oldLayer.removeFromParentAndCleanup(true)
                    buildingLayerArray.append(newLayer)
                    gamePhysicsNode.addChild(newLayer)
                }
            }
        }
    }
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        currentTouchLocation = touch.locationInWorld()
    }
    
    override func touchMoved(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        if !isGameOver{
            if hero.position.y < contentSizeInPoints.height - 30 - hero.contentSizeInPoints.height/2 * CGFloat(hero.scale) {
                var move = CCActionMoveTo(duration: 0.15, position: ccp(hero.position.x, CGFloat(clampf(Float(hero.position.y - (currentTouchLocation.y - touch.locationInWorld().y)), Float(0.0), Float(screenHeight)))))
                hero.runAction(move)
                currentTouchLocation = touch.locationInWorld()
                if hand != nil {
                    hand.removeFromParent()
                }
            }
        }
        
    }
    
}


// MARK: Game Center Handling
extension MainScene: GKGameCenterControllerDelegate {
    
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


