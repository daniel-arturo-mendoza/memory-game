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
    
    var backgroundMusicEasy: AnyObject = ""
    
    var backgroundMusicMedium: AnyObject = ""
    
    var backgroundMusicHard: AnyObject = ""
    
    
    override init(size: CGSize) {
        super.init(size: size)
        
        if #available(iOS 9.0, *) {
            backgroundMusicEasy = SKAudioNode(fileNamed: "easy_back_music.mp3")
            backgroundMusicMedium = SKAudioNode(fileNamed: "medium_back_music.mp3")
            backgroundMusicHard = SKAudioNode(fileNamed: "hard_back_music.mp3")
            
        } else {
            // No background music for earlier versions
        }
        
        
        deck = CardGameEngine.INSTANCE.getShuffledDeckForGame()
        
        if(deck?.count == DeckSizeEnum.SMALL.rawValue) {
            
            setCardsPosition(DeckSizeEnum.SMALL,
                             cardWidth: deck![0].frontTexture.size().width,
                             cardHeight: deck![0].frontTexture.size().height)
        } else if (deck?.count == DeckSizeEnum.MEDIUM.rawValue) {
            
            setCardsPosition(DeckSizeEnum.MEDIUM,
                             cardWidth: deck![0].frontTexture.size().width,
                             cardHeight: deck![0].frontTexture.size().height)
        } else { //don't check the deck size since we now it is the biggest
                 //and it could have 16 cards for iPhone 4 or 20 for all others
            
            setCardsPosition(DeckSizeEnum.LARGE,
                             cardWidth: deck![0].frontTexture.size().width,
                             cardHeight: deck![0].frontTexture.size().height)
        }
        
        menuButton.position = CGPointMake(self.size.width / 2, (menuButton.texture!.size().height) * 3.5);
        
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: #selector(self.playWrongPairSound(_:)), name: Constants.CARD_PAIR_DIFFERENT, object: CardGameEngine.INSTANCE)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: #selector(self.playCorrectPairSound(_:)), name: Constants.CARD_PAIR_EQUAL, object: CardGameEngine.INSTANCE)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: #selector(self.playGameWinSound(_:)), name: Constants.GAME_END, object: CardGameEngine.INSTANCE)
    }
    
    private func setCardsPosition(deckSize:DeckSizeEnum, cardWidth:CGFloat, cardHeight:CGFloat) {
        let _cardWidth:CGFloat = cardWidth
        let _cardHeight:CGFloat = cardHeight
        
        var xPadding = _cardWidth * 0.50
        var yPadding = _cardWidth * (deckSize == DeckSizeEnum.SMALL ? 0.1 : 0.20)
        if(deckSize == DeckSizeEnum.LARGE) {
            xPadding = _cardWidth * (modelName == "iPhone 6s Plus" ? 0.50 : 0.20)
            yPadding = _cardWidth * (modelName == "iPhone 6s Plus" ? 0.70 : 0.15)
        }
        
        var totalGameSpaceWidth:CGFloat
        var totalGameSpaceHeight:CGFloat
        if(deckSize == DeckSizeEnum.SMALL) {
            
            totalGameSpaceWidth =  (2 * cardWidth) + xPadding
            totalGameSpaceHeight = (3 * cardHeight) + (yPadding * 2)
            
        } else if(deckSize == DeckSizeEnum.MEDIUM) {
            
            totalGameSpaceWidth =  (3 * _cardWidth) +  (xPadding * 2)
            totalGameSpaceHeight = (4 * _cardHeight) + (yPadding * 3)
            
        } else {
            totalGameSpaceWidth =  (4 * _cardWidth) +  (xPadding * 3)
            
            if(modelName == "iPhone 4s") {
                totalGameSpaceHeight = (4 * _cardHeight) + (yPadding * 3)
            } else {
            
                totalGameSpaceHeight = (5 * _cardHeight) + (yPadding * 4)
            }
        }
        
        let x = (self.size.width  / 2) - (totalGameSpaceWidth  / 2) + (_cardWidth / 2)
        var y = (self.size.height / 2) + (totalGameSpaceHeight / 2) - (_cardHeight * 0.3)
        
        var xCount:CGFloat = 0
        var yCount:CGFloat = 0
        var index  = 0
        let cardsInRow = (deckSize == DeckSizeEnum.LARGE ? 4 : (deckSize == DeckSizeEnum.MEDIUM ? 3 : 2))
        
        var aux:Int = 0;
        for card in deck! {
            aux += 1
            if(index != cardsInRow){
                card.position = CGPointMake(x + ((xPadding + _cardWidth) * xCount), y)
            } else {
                index = 0
                xCount = 0
                yCount += 1
                y -= (yPadding + _cardHeight)
                card.position = CGPointMake(x + ((xPadding + _cardWidth) * xCount), y)
            }
            //print("\(card.id)+: \(card.position)")
            
            index += 1
            xCount += 1
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        
        if #available(iOS 9, *) {
            addBackgroundMusic()
        }
        
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
    
    @available(iOS 9, *)
    private func addBackgroundMusic() {
        //We wait half a second before playing the background music to avoid
        //music overlap and buggy behaviour
        
        runAction(SKAction.waitForDuration(0.5), completion: {
            if (CardGameEngine.INSTANCE.difficulty == DifficultyEnum.EASY) {
                self.addChild(self.backgroundMusicEasy as! SKAudioNode)
            } else if (CardGameEngine.INSTANCE.difficulty == DifficultyEnum.MEDIUM) {
                self.addChild(self.backgroundMusicMedium as! SKAudioNode)
            } else {
                self.addChild(self.backgroundMusicHard as! SKAudioNode)
            }
        })
    }
    
}
