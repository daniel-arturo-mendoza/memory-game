//
//  GameScene.swift
//  AnimationExercise
//
//  Created by Daniel Mendoza on 17/04/2016.
//  Copyright (c) 2016 Daniel Mendoza. All rights reserved.
//

import SpriteKit


class GameScene: SKScene, GameNotificationProtocol {
    
    let modelName = UIDevice.currentDevice().modelName
    
    var deck : [Card]?
    
    var menuButton:Button = Button(image: "button_70x66")
    
    let backgroundMusicEasy = SKAudioNode(fileNamed: "easy_back_music.mp3")
    
    let backgroundMusicMedium = SKAudioNode(fileNamed: "medium_back_music.mp3")
    
    let backgroundMusicHard = SKAudioNode(fileNamed: "hard_back_music.mp3")
    
    override init(size: CGSize) {
        super.init(size: size)
        
        deck = CardGameEngine.INSTANCE.getShuffledDeckForGame()
    
        var x:CGFloat = 100
        var y:CGFloat = 450
        
        if(/*modelName == "iPhone 5s"*/ modelName == "XXSimulator") {
            
            var xPad:CGFloat = 120
            var yPad:CGFloat = 160
            
            var index = 0
            var countP:CGFloat = 0
            var countO:CGFloat = 0
            
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
                
            } else { // Difficulty -> EASY
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
        
        } else { //any other iPhone will use positions according the resolution since they use the same size of cards.
            
            var xPadding:CGFloat = 120
            var yPadding:CGFloat = 160
            
            if(deck?.count == 6) {
                let cardWidth:CGFloat = 100
                let cardHeight:CGFloat = 141
                
                xPadding = cardWidth * 0.50
                yPadding = cardWidth * 0.10
                
                let totalGameSpaceWidth =  (2 * cardWidth) + xPadding
                let totalGameSpaceHeight = (3 * cardHeight) + (yPadding * 2)
                
                x = (self.size.width  / 2) - (totalGameSpaceWidth  / 2) + (cardWidth / 2)
                y = (self.size.height / 2) + (totalGameSpaceHeight / 2) - (cardHeight * 0.3)
                
                var counterP:CGFloat = 0
                var counterO:CGFloat = 0
                var index  = 0
                
                for card in deck! {
                    if(index % 2 == 0) {
                        card.position = CGPointMake(x, y - (counterP * (yPadding + cardHeight)))
                        counterP += 1
                    } else {
                        card.position = CGPointMake(x + cardWidth + xPadding, y - (counterO * (yPadding + cardHeight)))
                        counterO += 1
                    }
                    index += 1
                }
                
                menuButton.position = CGPointMake(self.size.width / 2, (menuButton.texture!.size().height) * 3.5);
            }
            
            if (deck?.count == 12) {
                let cardWidth:CGFloat = 70
                let cardHeight:CGFloat = 90
                
                xPadding = cardWidth * 0.50
                yPadding = cardWidth * 0.30
                
                let totalGameSpaceWidth =  (3 * cardWidth) +  (xPadding * 2)
                let totalGameSpaceHeight = (4 * cardHeight) + (yPadding * 3)
                
                x = (self.size.width  / 2) - (totalGameSpaceWidth  / 2) + (cardWidth / 2)
                y = (self.size.height / 2) + (totalGameSpaceHeight / 2) - (cardHeight * 0.3)
                
                var xCount:CGFloat = 0
                var yCount:CGFloat = 0
                var index  = 0
                
                for card in deck! {
                    if(index != 3){
                        card.position = CGPointMake(x + ((xPadding + cardWidth) * xCount), y)
                    } else {
                        index = 0
                        xCount = 0
                        yCount += 1
                        y -= (yPadding + cardHeight)
                        card.position = CGPointMake(x + ((xPadding + cardWidth) * xCount), y)
                    }
                    //print("\(card.id)+: \(card.position)")
                    
                    index += 1
                    xCount += 1
                }
                
                menuButton.position = CGPointMake(self.size.width / 2, (menuButton.texture!.size().height) * 3.5);
            }
            
            if (deck?.count == 20) {
                let cardWidth:CGFloat = 57
                let cardHeight:CGFloat = 80
                
                xPadding = cardWidth * (modelName == "iPhone 6s Plus"/*"Simulator"*/ ? 0.50 : 0.20)
                yPadding = cardWidth * (modelName == "iPhone 6s Plus"/*"Simulator"*/ ? 0.70 : 0.15)
                
                let totalGameSpaceWidth =  (3 * cardWidth) +  (xPadding * 2)
                let totalGameSpaceHeight = (4 * cardHeight) + (yPadding * 3)
                
                x = (self.size.width  / 2) -
                    (totalGameSpaceWidth  * (modelName == "iPhone 6s Plus"/*"Simulator"*/ ? 0.55 : 0.50))
                
                y = (self.size.height / 2) +
                    (totalGameSpaceHeight * (modelName == "iPhone 6s Plus"/*"Simulator"*/ ? 0.60 : 0.55))
                
                var xCount:CGFloat = 0
                var yCount:CGFloat = 0
                var index  = 0
                
                for card in deck! {
                    if(index != 4){
                        card.position = CGPointMake(x + ((xPadding + cardWidth) * xCount), y)
                    } else {
                        index = 0
                        xCount = 0
                        yCount += 1
                        y -= (yPadding + cardHeight)
                        card.position = CGPointMake(x + ((xPadding + cardWidth) * xCount), y)
                    }
                    //print("\(card.id)+: \(card.position)")
                    
                    index += 1
                    xCount += 1
                }
                
                menuButton.position = CGPointMake(self.size.width / 2, (menuButton.texture!.size().height) * 3.5);
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
        addBackgroundMusic()
        
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
    
    private func addBackgroundMusic() {
        //We wait half a second before playing the background music to avoid
        //music overlap and buggy behaviour
        
        runAction(SKAction.waitForDuration(0.5), completion: {
            if (CardGameEngine.INSTANCE.difficulty == DifficultyEnum.EASY) {
                self.addChild(self.backgroundMusicEasy)
            } else if (CardGameEngine.INSTANCE.difficulty == DifficultyEnum.MEDIUM) {
                self.addChild(self.backgroundMusicMedium)
            } else {
                self.addChild(self.backgroundMusicHard)
            }
        })
    }
    
}
