//
//  GameScene.swift
//  AnimationExercise
//
//  Created by Daniel Mendoza on 17/04/2016.
//  Copyright (c) 2016 Daniel Mendoza. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    //var bear : SKSpriteNode!
    //var bearWalkingFrames : [SKTexture]!
    //var movingAnimation : SKAction?
    var deck : [Card] = []
    var card1:  Card?
    var card2:  Card?
    var card3:  Card?
    var card4:  Card?
    var card5:  Card?
    var card6:  Card?
    var card7:  Card?
    var card8:  Card?
    
    override init(size: CGSize) {
        super.init(size: size)
        
        card1 = Card(imageNamedFront: "c1.jpg", imageNamedBack: "c1.jpg")
        card1!.position = CGPointMake(self.size.width/2, self.size.height/2)
        
        card2 = Card(imageNamedFront: "c2.jpg", imageNamedBack: "c1.jpg")
        card2!.position = CGPointMake((self.size.width/2)+100, (self.size.height/2)+100)
        
        card3 = Card(imageNamedFront: "c3.jpg", imageNamedBack: "c1.jpg")
        card3!.position = CGPointMake((self.size.width/2)+100, (self.size.height/2)+100)
        
        card4 = Card(imageNamedFront: "c4.jpg", imageNamedBack: "c1.jpg")
        card4!.position = CGPointMake((self.size.width/2)+100, (self.size.height/2)+100)
        
        card5 = Card(imageNamedFront: "c5.jpg", imageNamedBack: "c1.jpg")
        card5!.position = CGPointMake((self.size.width/2)+100, (self.size.height/2)+100)
        
        card6 = Card(imageNamedFront: "c6.jpg", imageNamedBack: "c1.jpg")
        card6!.position = CGPointMake((self.size.width/2)+100, (self.size.height/2)+100)
        
        card7 = Card(imageNamedFront: "c7.jpg", imageNamedBack: "c1.jpg")
        card7!.position = CGPointMake((self.size.width/2)+100, (self.size.height/2)+100)
        
        card8 = Card(imageNamedFront: "c8.jpg", imageNamedBack: "c1.jpg")
        card8!.position = CGPointMake((self.size.width/2)+100, (self.size.height/2)+100)
        
        deck.append(card1!)
        deck.append(card2!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = (UIColor.blackColor())
        
        
        /*
         let card = Card(imageNamedFront: "card_texture_front@1.png", imageNamedBack: "card_texture_back@1.png")
         card.position = CGPointMake(self.size.width/2, self.size.height/2)
         addChild(card)
         */
        for _card in deck {
            addChild(_card)
        }
        
        //addChild(deck.popLast()!)
        
        //setupAnimation()
        
        //walkingBear()
        //bear?.runAction(movingAnimation!)
    }
    
    /*override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
     for touch in touches {
     let location = touch.locationInNode(self)
     let touchedNode = nodeAtPoint(location)
     touchedNode.position = location
     }
     }
     
     override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
     for touch in touches {
     let location = touch.locationInNode(self)
     let touchedNode = nodeAtPoint(location)
     touchedNode.zPosition = 15
     
     let liftUp = SKAction.scaleTo(1.2, duration: 0.2)
     touchedNode.runAction(liftUp, withKey: "pickup")
     }
     }
     
     override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
     for touch in touches {
     let location = touch.locationInNode(self)
     let touchedNode = nodeAtPoint(location)
     touchedNode.zPosition = 0
     
     let dropDown = SKAction.scaleTo(1.0, duration: 0.2)
     touchedNode.runAction(dropDown, withKey: "drop")
     }
     }*/
    
    func setupAnimation() {
        let bearAnimatedAtlas = SKTextureAtlas(named: "BearImages")
        var walkFrames = [SKTexture]()
        
        let numImages = bearAnimatedAtlas.textureNames.count
        
        for var i=1; i<=numImages/2; i += 1 {
            let bearTextureName = "bear\(i)@2x~ipad.png"
            walkFrames.append(bearAnimatedAtlas.textureNamed(bearTextureName))
        }
        
        //bear = SKSpriteNode(texture: walkFrames[0])
        //bear.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        //bearWalkingFrames = walkFrames
        
        //addChild(bear)
        
        //This is our general runAction method to make our bear walk.
        //let animation = SKAction.animateWithTextures(bearWalkingFrames, timePerFrame: 0.1, resize: false, restore: true)
        //movingAnimation = SKAction.repeatAction(animation, count: 5)
        
    }
    
    
    /*func walkingBear() {
     //This is our general runAction method to make our bear walk.
     bear.runAction(SKAction.repeatActionForever(
     SKAction.animateWithTextures(bearWalkingFrames,
     timePerFrame: 0.1,
     resize: false,
     restore: true)),
     withKey:"walkingInPlaceBear")
     }*/
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
