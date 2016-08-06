//
//  ModalViewController.swift
//  MemoryGame
//
//  Created by Daniel Mendoza on 06/07/2016.
//  Copyright © 2016 Daniel Mendoza. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class ModalViewController: UIViewController, GameNotificationProtocol {
    
    @objc func actionContinue() {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @objc func dismiss() {
        //To be overriden 
    }
    
    func postNotificationName (notificationName:String) {
        NSNotificationCenter.defaultCenter().postNotificationName(notificationName, object: self)
    }
    
}

    