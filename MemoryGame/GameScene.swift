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
    
    let x:CGFloat = 100
    let y:CGFloat = 450
    
    var deck : [Card] = CardGameEngine.INSTANCE.getShuffledDeck()
    
    override init(size: CGSize) {
        super.init(size: size)
        
        if(modelName == "iPhone 5s" || modelName == "Simulator") {
            
            let xPad:CGFloat = 120
            let yPad:CGFloat = 160
            
            var index = 0
            var countP:CGFloat = 0
            var countO:CGFloat = 0
            
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
            _card.flip()//this is a workaround. need to think in a better impleemtation
            addChild(_card)
        }
    }

}
