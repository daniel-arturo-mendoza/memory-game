//
//  GameScene.swift
//  AnimationExercise
//
//  Created by Daniel Mendoza on 17/04/2016.
//  Copyright (c) 2016 Daniel Mendoza. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    
    let modelName = UIDevice.currentDevice().modelName
    
    var deck : [Card]?
    
    var menuButton:Button = Button(image: "button_70x66")
    
    override init(size: CGSize) {
        super.init(size: size)
        
        deck = CardGameEngine.INSTANCE.getShuffledDeckForGame()
    
        var x:CGFloat = 100
        var y:CGFloat = 450
        
        if(modelName == "iPhone 5s" || modelName == "Simulator") {
            
            var xPad:CGFloat = 120
            var yPad:CGFloat = 160
            
            var index = 0
            var countP:CGFloat = 0
            var countO:CGFloat = 0
            
            //if(CardGameEngine.INSTANCE.cardSize != nil) {
                if (CardGameEngine.INSTANCE.cardSize == Constants.BIG_CARDS_5S) {
                    xPad = 120
                    yPad = 160
                
                } else if (CardGameEngine.INSTANCE.cardSize == Constants.MEDIUM_CARDS_5S) {
                    xPad = 120
                    
                    y = 510
                    yPad = 110
                
                } else {
                    xPad = 120
                    yPad = 40
                }
                
            //}
            
            if (CardGameEngine.INSTANCE.difficulty == DifficultyEnum.HARD) {
                x = 55
                y = 520
                
                xPad = 70
                yPad = 90
                
                var _index = 0
                var _y:CGFloat = y
                var xCount:CGFloat = 0
                var yCount:CGFloat = 0
                
                for card in deck! {
                    if(_index != 4){
                        card.position = CGPointMake(x + (xPad * xCount), _y)
                    } else {
                        _index = 0
                        xCount = 0
                        yCount += 1
                        _y -= yPad
                        card.position = CGPointMake(x + (xPad * xCount), _y)
                    }
                    //print("\(card.id)+: \(card.position)")
                    
                    _index += 1
                    xCount += 1
                }
                menuButton.position = CGPointMake(50,50)
                
            } else if(CardGameEngine.INSTANCE.difficulty == DifficultyEnum.MEDIUM) {
                x = 70
                y = 510
                
                xPad = 90
                yPad = 110
                
                var _index = 0
                var _y:CGFloat = y
                var xCount:CGFloat = 0
                var yCount:CGFloat = 0
                
                for card in deck! {
                    if(_index != 3){
                        card.position = CGPointMake(x + (xPad * xCount), _y)
                    } else {
                        _index = 0
                        xCount = 0
                        yCount += 1
                        _y -= yPad
                        card.position = CGPointMake(x + (xPad * xCount), _y)
                    }
                    //print("\(card.id)+: \(card.position)")
                    
                    _index += 1
                    xCount += 1
                }
                menuButton.position = CGPointMake(50,50)
                
            } else {
                x = 100
                y = 480
                
                xPad = 120
                yPad = 160
                
                for card in deck! {
                    if(index % 2 == 0) {
                        card.position = CGPointMake(x , y - (yPad * countP))
                        countP += 1
                    } else {
                        card.position = CGPointMake(x + xPad, y - (yPad * countO))
                        countO += 1
                    }
                    index += 1
                }
                menuButton.position = CGPointMake(50,50)
            }
        }
        
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: #selector(self.playWrongPairSound(_:)), name: Constants.CARD_PAIR_DIFFERENT, object: CardGameEngine.INSTANCE)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: #selector(self.playCorrectPairSound(_:)), name: Constants.CARD_PAIR_EQUAL, object: CardGameEngine.INSTANCE)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: #selector(self.playGameWinSound(_:)), name: Constants.GAME_END, object: CardGameEngine.INSTANCE)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        backgroundColor = (UIColor.whiteColor())
        
        for _card in deck! {
            _card.flip()//this is a workaround. need to think in a better implemtation
            addChild(_card)
        }
        
        menuButton.action = Constants.GAME_MODAL_MENU
        
        addChild(menuButton)
    }
    
    @objc func playWrongPairSound(notification: NSNotification) {
        runAction(SKAction.playSoundFileNamed("power_down.mp3", waitForCompletion: false))
    }
    
    @objc func playCorrectPairSound(notification: NSNotification) {
        runAction(SKAction.playSoundFileNamed("power_up.mp3", waitForCompletion: false))
    }
    
    @objc func playGameWinSound(notification: NSNotification) {
        runAction(SKAction.playSoundFileNamed("game_win.mp3", waitForCompletion: false))
    }
    
    func postNotificationName (notificationName:String) {
        NSNotificationCenter.defaultCenter().postNotificationName(notificationName, object: self)
    }
    
}
