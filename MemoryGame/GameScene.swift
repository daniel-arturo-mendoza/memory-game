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
    
    var x:CGFloat = 100
    var y:CGFloat = 450
    
    var deck : [Card] = CardGameEngine.INSTANCE.getShuffledDeckForGame()
    
    override init(size: CGSize) {
        super.init(size: size)
        
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
                x = 60
                y = 520
                
                xPad = 100
                yPad = 90
                
                var _index = 0
                var _y:CGFloat = y
                var xCount:CGFloat = 0
                var yCount:CGFloat = 0
                
                for card in deck {
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
                
            } else {
            
                for card in deck {
                    if(index % 2 == 0) {
                        card.position = CGPointMake(x , y - (yPad * countP))
                        countP += 1
                    } else {
                        card.position = CGPointMake(x + xPad, y - (yPad * countO))
                        countO += 1
                    }
                    index += 1
                }
            }
            /*deck[0].position = CGPointMake(x , y)
            deck[2].position = CGPointMake(x , y - yPad)
            deck[4].position = CGPointMake(x , y - (yPad + yPad))
            
            deck[1].position = CGPointMake(x + xPad, y)
            deck[3].position = CGPointMake(x + xPad, y - yPad)
            deck[5].position = CGPointMake(x + xPad, y - (yPad + yPad))
            */
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = (UIColor.blackColor())
        
        for _card in deck {
            _card.flip()//this is a workaround. need to think in a better implemtation
            addChild(_card)
        }
    }

}
