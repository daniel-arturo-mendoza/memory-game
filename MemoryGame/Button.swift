//
//  Button.swift
//  MemoryGame
//
//  Created by Daniel Mendoza on 27/06/2016.
//  Copyright © 2016 Daniel Mendoza. All rights reserved.
//

import Foundation
import SpriteKit

class Button: SKSpriteNode {
    
    var id = "";
    var buttonTexture: SKTexture!
    
    required init(coder aDecoder: NSCoder){
        fatalError("NSCoding not Supported")
    }
    
    init(image: String) {
        id = image
        buttonTexture = SKTexture(imageNamed: image)
        
        super.init(texture: buttonTexture, color: UIColor.clearColor(), size: buttonTexture.size())
        userInteractionEnabled = true
        name = image
    }
    
    init(id: String, texture:SKTexture, color:UIColor, size:CGSize) {
        self.id = id
        
        super.init(texture: texture, color: color, size: size)
        userInteractionEnabled = true
        name = id
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for _ in touches {
            // note: removed references to touchedNode
            // 'self' in most cases is not required in Swift
            zPosition = 15
            let bounce = SKAction.scaleTo(1.1, duration: 0.05)
            runAction(bounce, withKey: "bounce")
            
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
        }
    }
    
    func postNotificationName (notificationName:String) {
        
        NSNotificationCenter.defaultCenter().postNotificationName(notificationName, object: self)
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