//
//  Card.swift
//  AnimationExercise
//
//  Created by Daniel Mendoza on 19/04/2016.
//  Copyright © 2016 Daniel Mendoza. All rights reserved.
//

import Foundation
import SpriteKit

class Card: SKSpriteNode {
    
    var faceUp = true
    var id = "";
    let frontTexture: SKTexture!
    let backTexture: SKTexture!
    
    required init(coder aDecoder: NSCoder){
        fatalError("NSCoding not Supported")
    }
    
    init(imageNamedFront: String, imageNamedBack: String) {
        id = imageNamedFront;
        frontTexture = SKTexture(imageNamed: imageNamedFront)
        backTexture = SKTexture(imageNamed: imageNamedBack)
        
        super.init(texture: frontTexture, color: UIColor.clearColor(), size: frontTexture.size())
        userInteractionEnabled = true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for _ in touches {
            
            //if touch.tapCount > 1 {
            flip()
            //}
            
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
        for touch in touches {
            let location = touch.locationInNode(scene!) // make sure this is scene, not self
            let touchedNode = nodeAtPoint(location)
            touchedNode.position = location
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for _ in touches {
            zPosition = 0
            let dropDown = SKAction.scaleTo(1.0, duration: 0.2)
            runAction(dropDown, withKey: "drop")
            removeActionForKey("wiggle")
        }
    }
    
    func flip() {
        if faceUp {
            self.texture = self.backTexture
            //if let damageLabel = self.childNodeWithName("damageLabel") {
            //    damageLabel.hidden = true
            //}
            self.faceUp = false
            
            print("flipping - Face DOWN")
            
        } else {
            self.texture = self.frontTexture
            //if let damageLabel = self.childNodeWithName("damageLabel") {
            //    damageLabel.hidden = false
            //}
            self.faceUp = true
            
            print("flipping - Face UP")
            
        }
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        if let object = object as? Card {
            return id == object.id
        } else {
            return false
        }
    }
    
    override var hash: Int {
        return id.hashValue
    }
    
}
