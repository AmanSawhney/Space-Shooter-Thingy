//
//  Store.swift
//  ModernSpaceShooter
//
//  Created by Gagandeep Sawhney on 8/21/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit
import StoreKit
//  You can use this protocol to notify some object that purchases completed
protocol IAPHelperDelegate {
    
    func purchaseSuccessful(productString: String)
    func purchaseFailed()
    
}
class Store: CCNode, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    var purchase: String!
    var alertBuyShit = UIAlertView()
    var alertShip2 = UIAlertView()
    weak var ship2Button: CCButton!
    weak var ship3Button: CCButton!
    weak var ship4Button: CCButton!
    weak var removebutton: CCButton!
    func didLoadFromCCB() {
        purchase = "hi"
    }
    func removeAds() {
        alertBuyShit.tag = 5
        alertBuyShit.delegate = self
        alertBuyShit.title = "Remove all ads!"
        alertBuyShit.message = "Remove all ads from this game and play interruption free!"
        alertBuyShit.addButtonWithTitle("Purchase")
        alertBuyShit.addButtonWithTitle("Restore")
        alertBuyShit.addButtonWithTitle("Cancel")
        alertBuyShit.show()
    }
    func buyShit() {
        alertBuyShit.tag = 1
        alertBuyShit.delegate = self
        alertBuyShit.title = "Buy Coins"
        alertBuyShit.message = "Buy 500 pristine gold coins. You know you want it"
        alertBuyShit.addButtonWithTitle("Purchase")
        alertBuyShit.addButtonWithTitle("Cancel")
        alertBuyShit.show()
    }
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int)
    {
        if alertView.tag == 1 {
            switch buttonIndex
            {
            case 0:
                attemptPurchase("com.SawhneyGames.Coins")
                purchase = "Coins"
            default:
                break
            }
        }
        if alertView.tag == 2 {
            switch buttonIndex
            {
            case 0:
                var coins = NSUserDefaults.standardUserDefaults().integerForKey("coins")
                if coins >= 250 {
                    coins -= 250
                    NSUserDefaults.standardUserDefaults().setInteger(coins, forKey: "coins")
                    var OWEND = NSUserDefaults.standardUserDefaults().integerForKey("OWEND")
                    OWEND = 1
                    NSUserDefaults.standardUserDefaults().setInteger(OWEND, forKey: "OWEND")
                }
                else {
                    var alert = UIAlertView()
                    alert.delegate = self
                    alert.title = "You Don't Have Enough Coins "
                    alert.message = "PLAY THE GAME"
                    alert.addButtonWithTitle("OK I WILL PLAY")
                    alert.show()
                }
            default:
                break
            }
        }
        if alertView.tag == 3 {
            switch buttonIndex
            {
            case 0:
                var coins = NSUserDefaults.standardUserDefaults().integerForKey("coins")
                if coins >= 500 {
                    coins -= 500
                    NSUserDefaults.standardUserDefaults().setInteger(coins, forKey: "coins")
                    var OWEND = NSUserDefaults.standardUserDefaults().integerForKey("OWEND")
                    OWEND = 2
                    NSUserDefaults.standardUserDefaults().setInteger(OWEND, forKey: "OWEND")
                }
                else {
                    var alert = UIAlertView()
                    alert.delegate = self
                    alert.title = "You Don't Have Enough Coins "
                    alert.message = "PLAY THE GAME"
                    alert.addButtonWithTitle("OK I WILL PLAY")
                    alert.show()
                }
            default:
                break
            }
        }
        if alertView.tag == 4 {
            switch buttonIndex
            {
            case 0:
                var coins = NSUserDefaults.standardUserDefaults().integerForKey("coins")
                if coins >= 1000 {
                    coins -= 1000
                    NSUserDefaults.standardUserDefaults().setInteger(coins, forKey: "coins")
                    var OWEND = NSUserDefaults.standardUserDefaults().integerForKey("OWEND")
                    OWEND = 3
                    NSUserDefaults.standardUserDefaults().setInteger(OWEND, forKey: "OWEND")
                }
                else {
                    var alert = UIAlertView()
                    alert.delegate = self
                    alert.title = "You Don't Have Enough Coins "
                    alert.message = "PLAY THE GAME"
                    alert.addButtonWithTitle("OK I WILL PLAY")
                    alert.show()
                }
            default:
                break
            }
        }
        if alertView.tag == 5 {
            switch buttonIndex
            {
            case 0:
                attemptPurchase("com.SawhneyGames.Ads")
                purchase = "Ads"
            case 1:
                attemptRestorePurchase()
            default:
                break
            }
        }

    }
    func ship1() {
        NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "player")
        let scene = CCBReader.loadAsScene("MainScene")
        CCDirector.sharedDirector().presentScene(scene)  
    }
    func ship2() {
        var OWEND = NSUserDefaults.standardUserDefaults().integerForKey("OWEND")
        if OWEND < 1 {
            alertShip2.tag = 2
            alertShip2.delegate = self
            alertShip2.title = "Buy this ship!"
            alertShip2.message = "Buy this ship with 250 pristine gold coins. You know you want it!"
            alertShip2.addButtonWithTitle("Purchase")
            alertShip2.addButtonWithTitle("Cancel")
            alertShip2.show()
        }else {
            NSUserDefaults.standardUserDefaults().setInteger(2, forKey: "player")
            let scene = CCBReader.loadAsScene("MainScene")
            CCDirector.sharedDirector().presentScene(scene)
        }
    }
    func ship3() {
        var OWEND = NSUserDefaults.standardUserDefaults().integerForKey("OWEND")
        if OWEND < 2 {
            alertShip2.tag = 3
            alertShip2.delegate = self
            alertShip2.title = "Buy this ship!"
            alertShip2.message = "Buy this ship with 500 pristine gold coins. You know you want it!"
            alertShip2.addButtonWithTitle("Purchase")
            alertShip2.addButtonWithTitle("Cancel")
            alertShip2.show()
        }else {
            NSUserDefaults.standardUserDefaults().setInteger(3, forKey: "player")
            let scene = CCBReader.loadAsScene("MainScene")
            CCDirector.sharedDirector().presentScene(scene)
        }
    }
    func ship4() {
        var OWEND = NSUserDefaults.standardUserDefaults().integerForKey("OWEND")
        if OWEND < 3 {
            alertShip2.tag = 4
            alertShip2.delegate = self
            alertShip2.title = "Buy this ship!"
            alertShip2.message = "Buy this ship with 1000 pristine gold coins. You know you want it!"
            alertShip2.addButtonWithTitle("Purchase")
            alertShip2.addButtonWithTitle("Cancel")
            alertShip2.show()
        }else {
            NSUserDefaults.standardUserDefaults().setInteger(4, forKey: "player")
            let scene = CCBReader.loadAsScene("MainScene")
            CCDirector.sharedDirector().presentScene(scene)
        }
    }
    var delegate: IAPHelperDelegate?
    
    //called by you, to start purchase process
    func attemptPurchase(productName: String) {
        if (SKPaymentQueue.canMakePayments()) {
            var productID:NSSet = NSSet(object: productName)
            var productRequest:SKProductsRequest = SKProductsRequest(productIdentifiers: productID as Set<NSObject>)
            productRequest.delegate = self
            productRequest.start()
        } else {
            //notify user that purchase isn't possible
            if let delegate = delegate {
                delegate.purchaseFailed()
            }
        }
    }
    
    //called by you, to start restore purchase process
    func attemptRestorePurchase() {
        if (SKPaymentQueue.canMakePayments()) {
            SKPaymentQueue.defaultQueue().restoreCompletedTransactions()
        } else {
            //notify user that restore isn't possible
            if let delegate = delegate {
                delegate.purchaseFailed()
            }
        }
    }
    
    //called after delegate method productRequest(...)
    func buyProduct(product: SKProduct) {
        var payment = SKPayment(product: product)
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
        SKPaymentQueue.defaultQueue().addPayment(payment)
    }
    
    // MARK: - SKProductsRequestDelegate method
    
    func productsRequest(request: SKProductsRequest!, didReceiveResponse response: SKProductsResponse!) {
        var count: Int = response.products.count
        if (count > 0) {
            var validProducts = response.products
            var product = validProducts[0] as! SKProduct
            buyProduct(product)
        } else {
            //something went wrong with lookup, try again?
        }
    }
    
    // MARK: - SKPaymentTransactionObserver method
    
    //SKPaymentTransactionObserver method
    func paymentQueue(queue: SKPaymentQueue!, updatedTransactions transactions: [AnyObject]!) {
        println("recieved response")
        for transaction: AnyObject in transactions {
            if let tx: SKPaymentTransaction = transaction as? SKPaymentTransaction {
                switch tx.transactionState {
                case .Purchased, .Restored:
                    if purchase == "Coins" {
                    var coins = NSUserDefaults.standardUserDefaults().integerForKey("coins")
                    coins += 500
                    NSUserDefaults.standardUserDefaults().setInteger(coins, forKey: "coins")
                    queue.finishTransaction(tx)
                    }
                    if purchase == "Ads" {
                        var ads = NSUserDefaults.standardUserDefaults().boolForKey("ads")
                        ads = true
                        NSUserDefaults.standardUserDefaults().setBool(ads, forKey: "ads")
                    }
                case .Failed:
                    alertBuyShit.tag = 13
                    alertBuyShit.delegate = self
                    alertBuyShit.title = "IM SORRY"
                    alertBuyShit.message = "IT LOOKS LIKE THE PURCHASE DIDNT WORK I AM SORRY"
                    alertBuyShit.addButtonWithTitle("AWWW")
                    alertBuyShit.addButtonWithTitle("I'M MAD")
                    alertBuyShit.addButtonWithTitle("ITS OK")
                    alertBuyShit.show()

                    purchase = "hi"
                    println("oops, purchase failed!")
                    queue.finishTransaction(tx)
                case .Purchasing, .Deferred:
                    println("waiting for completion...")
                }
            }
        }
    }
    override func update(delta: CCTime) {
        println(removebutton.title)
        var ads = NSUserDefaults.standardUserDefaults().boolForKey("ads")
        if ads {
            removebutton.title = "Purchased"
        }
        var OWEND = NSUserDefaults.standardUserDefaults().integerForKey("OWEND")
        if OWEND >= 1 {
            ship2Button.title = "CHOOSE"
        }
        if OWEND >= 2 {
            ship3Button.title = "CHOOSE"
        }
        if OWEND >= 3 {
           ship4Button.title = "CHOOSE"
        }
        
    }
    
}


