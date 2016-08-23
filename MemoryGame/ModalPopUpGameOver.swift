//
//  ModalPopUpGameOver.swift
//  MemoryGame
//
//  Created by Daniel Mendoza on 08/07/2016.
//  Copyright © 2016 Daniel Mendoza. All rights reserved.
//

import Foundation
import Foundation
import UIKit
import SpriteKit

class ModalPopUpGameOver: ModalViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        view.opaque = false
        
        let x:CGFloat =  view.center.x
        let y:CGFloat =  view.center.y
        
        let image0 = UIImage(named: "level_complete") as UIImage?
        let imageView = UIImageView(image: image0)
        imageView.frame = CGRectMake(x-(((image0?.size.width)!)/2),
                                     y - 160,
                                     (image0?.size.width)!,
                                     (image0?.size.height)!)
        view.addSubview(imageView)
        
        let image1 = UIImage(named: "go_to_menu") as UIImage?
        let buttonGoToMenu   = UIButton(type: UIButtonType.Custom) as UIButton
        buttonGoToMenu.frame = CGRectMake(x-(((image1?.size.width)!)/2),
                                          y - 30,
                                          (image1?.size.width)!,
                                          (image1?.size.height)!)
        buttonGoToMenu.setImage(image1, forState: .Normal)
        buttonGoToMenu.addTarget(self, action: #selector(dismiss), forControlEvents:.TouchUpInside)
        view.addSubview(buttonGoToMenu)
        
        let image2 = UIImage(named: "restart_152x60") as UIImage?
        let buttonRestart   = UIButton(type: UIButtonType.Custom) as UIButton
        buttonRestart.frame = CGRectMake(x-(((image2?.size.width)!)/2),
                                         y + 35,
                                         (image2?.size.width)!,
                                         (image2?.size.height)!)
        buttonRestart.setImage(image2, forState: .Normal)
        buttonRestart.addTarget(self, action: #selector(restart), forControlEvents:.TouchUpInside)
        view.addSubview(buttonRestart)
        
        if(CardGameEngine.INSTANCE.difficulty != DifficultyEnum.HARD){
            let image3 = UIImage(named: "next_level_217x60") as UIImage?
            let buttonNextLevel   = UIButton(type: UIButtonType.Custom) as UIButton
            buttonNextLevel.frame = CGRectMake(x-(((image3?.size.width)!)/2),
                                               y + 110,
                                               (image3?.size.width)!,
                                               (image3?.size.height)!)
            buttonNextLevel.setImage(image3, forState: .Normal)
            buttonNextLevel.addTarget(self, action: #selector(nextLevel), forControlEvents:.TouchUpInside)
            view.addSubview(buttonNextLevel)
        }
        
    }
    
    @objc override func dismiss() {
        //Notify game view controller to show the menu
        self.dismissViewControllerAnimated(true, completion: {});
        postNotificationName(Constants.GAME_MENU)
    }
    
    @objc func restart() {
        self.dismissViewControllerAnimated(true, completion: {});
        postNotificationName(Constants.RESTART_GAME)
    }
    
    @objc func nextLevel() {
        self.dismissViewControllerAnimated(true, completion: {});
        postNotificationName(Constants.NEXT_LEVEL)
    }
    
}