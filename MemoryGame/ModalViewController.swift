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

class ModalViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 1, alpha: 0.5)//UIColor.clearColor()
        view.opaque = false
        
        let x:CGFloat =  view.center.x
        let y:CGFloat =  view.center.y
        
        let image1 = UIImage(named: "continue") as UIImage?
        let buttonContinue   = UIButton(type: UIButtonType.Custom) as UIButton
        buttonContinue.frame = CGRectMake(x-(((image1?.size.width)!)/2),
                                  y - 60,
                                  (image1?.size.width)!,
                                  (image1?.size.height)!)
        buttonContinue.setImage(image1, forState: .Normal)
        buttonContinue.addTarget(self, action: #selector(ModalViewController.actionContinue), forControlEvents:.TouchUpInside)
        view.addSubview(buttonContinue)
        
        let image2 = UIImage(named: "go_to_menu") as UIImage?
        let buttonGoToMenu   = UIButton(type: UIButtonType.Custom) as UIButton
        buttonGoToMenu.frame = CGRectMake(x-(((image2?.size.width)!)/2),
                                  y - 160,
                                  (image2?.size.width)!,
                                  (image2?.size.height)!)
        buttonGoToMenu.setImage(image2, forState: .Normal)
        buttonGoToMenu.addTarget(self, action: #selector(ModalViewController.actionGoToMenu), forControlEvents:.TouchUpInside)
        view.addSubview(buttonGoToMenu)
    }
    
    @objc func actionContinue() {
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    @objc func actionGoToMenu() {
        //Notify game view controller to show the menu
        self.dismissViewControllerAnimated(true, completion: {});
        postNotificationName(Constants.GAME_MENU)
    }
    
    func postNotificationName (notificationName:String) {
        NSNotificationCenter.defaultCenter().postNotificationName(notificationName, object: self)
    }
    
}