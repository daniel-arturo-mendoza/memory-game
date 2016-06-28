//
//  GameMenuScene.swift
//  MemoryGame
//
//  Created by Daniel Mendoza on 27/06/2016.
//  Copyright © 2016 Daniel Mendoza. All rights reserved.
//

import Foundation
import SpriteKit

class GameMenuScene: SKScene {
    
    let modelName = UIDevice.currentDevice().modelName
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = (UIColor.blackColor())
        
        addButtons()
        startGame()
    }
    
    private func addButtons() {
        let easyBtn = DifficultyButton(image: "easy.png", difficulty: DifficultyEnum.EASY)
        easyBtn.position = CGPointMake(self.size.width/2 , self.size.height/2)
        
        let medBtn = DifficultyButton(image: "medium.png", difficulty: DifficultyEnum.MEDIUM)
        medBtn.position = CGPointMake(self.size.width/2 , (self.size.height/2)-60)
        
        let hardBtn = DifficultyButton(image: "hard.png", difficulty: DifficultyEnum.HARD)
        hardBtn.position = CGPointMake(self.size.width/2 , (self.size.height/2)-120)
        
        /*if(modelName == "iPhone 5s" || modelName == "Simulator") {
            
            let xPad:CGFloat = 120
            let yPad:CGFloat = 160
            
            var index = 0
            var countP:CGFloat = 0
            var countO:CGFloat = 0
            
        }*/
        
        
        addChild(easyBtn)
        addChild(medBtn)
        addChild(hardBtn)
    }
    
    private func startGame() {
        let gameScene = GameScene(size: view!.bounds.size)
        let transition = SKTransition.fadeWithDuration(10)
        view!.presentScene(gameScene, transition: transition)
        
    }
    
}