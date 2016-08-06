//
//  Card.swift
//  AnimationExercise
//
//  Created by Daniel Mendoza on 19/04/2016.
//  Copyright © 2016 Daniel Mendoza. All rights reserved.
//

import Foundation
import SpriteKit

class Card: SKSpriteNode, GameNotificationProtocol {
    
    var faceUp = true
    var id = "";
    let frontTexture: SKTexture!
    let backTexture: SKTexture!
    
    let textureName:String!
    
    var isCopy:BooleanType = false
    
    required init(coder aDecoder: NSCoder){
        fatalError("NSCoding not Supported")
    }
    
    init(imageNamedFront: String, imageNamedBack: String) {
        frontTexture = SKTexture(imageNamed: imageNamedFront)
        backTexture = SKTexture(imageNamed: imageNamedBack)
        textureName = imageNamedFront
        
        super.init(texture: frontTexture, color: UIColor.clearColor(), size: frontTexture.size())
        userInteractionEnabled = true
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for _ in touches {
            // note: removed references to touchedNode
            // 'self' in most cases is not required in Swift
            zPosition = 15
            let liftUp = SKAction.scaleTo(1.1, duration: 0.05)
            runAction(liftUp, withKey: "pickup")
            
            let wiggleIn = SKAction.scaleXTo(1.0, duration: 0.05)
            let wiggleOut = SKAction.scaleXTo(1.1, duration: 0.05)
            let wiggle = SKAction.sequence([wiggleIn, wiggleOut])
            //let wiggleRepeat = SKAction.repeatActionForever(wiggle)
            
            // again, since this is the touched sprite
            // run the action on self (implied)
            //runAction(wiggleRepeat, withKey: "wiggle")
            runAction(wiggle, withKey: "wiggle")
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /*for touch in touches {
            let location = touch.locationInNode(scene!) // make sure this is scene, not self
            let touchedNode = nodeAtPoint(location)
            touchedNode.position = location
        }*/
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for _ in touches {
            zPosition = 0
            let dropDown = SKAction.scaleTo(1.0, duration: 0.2)
            runAction(dropDown, withKey: "drop")
            removeActionForKey("wiggle")
            
            reveal()
            postNotificationName(Constants.CARD_REVEAL_NOTIFY)
        }
    }
    
    func reveal() -> Bool {
        if(!faceUp){
            if(doFlip()) {
                runAction(SKAction.playSoundFileNamed("card-flip.wav", waitForCompletion: false))
                return true
            } else {
                return false
            }
        } else {
            print("\(id) card already revealed!!")
            return false
        }
    }
    
    var revCard = 0
    func doFlip() -> Bool {
        revCard = CardGameEngine.INSTANCE.canFlip(self)
        if(revCard > 0){
            flip()
            return true
        }
        return false
    }
    
    func flip() {
        if faceUp {
            self.texture = self.backTexture
            self.faceUp = false
            //print("\(id) flipping - Face DOWN - Pos: \(self.position)")
        
        } else {
            self.texture = self.frontTexture
            self.faceUp = true
            //print("\(id) flipping - Face UP - Pos: \(self.position)")
        }
    }
    
    func isFaceUp() -> Bool{
        return self.faceUp
    }
    
    func postNotificationName (notificationName:String) {
        NSNotificationCenter.defaultCenter().postNotificationName(notificationName, object: self)
    }
    
    /*override func isEqual(object: AnyObject?) -> Bool {
        if let object = object as? Card {
            return hashValue == object.hashValue
        } else {
            return false
        }
    }
    
    override var hashValue: Int {
        get {
            return "\(self.frontTexture),\(self.backTexture),\(self.isCopy)".hashValue
        }
    }*/
    
}
