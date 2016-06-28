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
    var easyBtn:DifficultyButton?
    var medBtn:DifficultyButton?
    var hardBtn:DifficultyButton?
    
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
        addListeners()
    }
    
    private func addButtons() {
        easyBtn = DifficultyButton(image: "easy.png", setDifficultyAction: Constants.START_GAME_EASY)
        easyBtn!.position = CGPointMake(self.size.width/2 , self.size.height/2)
        
        medBtn = DifficultyButton(image: "medium.png", setDifficultyAction: Constants.START_GAME_MEDIUM)
        medBtn!.position = CGPointMake(self.size.width/2 , (self.size.height/2)-60)
        
        hardBtn = DifficultyButton(image: "hard.png", setDifficultyAction: Constants.START_GAME_HARD)
        hardBtn!.position = CGPointMake(self.size.width/2 , (self.size.height/2)-120)
        
        /*if(modelName == "iPhone 5s" || modelName == "Simulator") {
            
            let xPad:CGFloat = 120
            let yPad:CGFloat = 160
            
            var index = 0
            var countP:CGFloat = 0
            var countO:CGFloat = 0
            
        }*/
        
        addChild(easyBtn!)
        addChild(medBtn!)
        addChild(hardBtn!)
    }
    
    private func startGame() {
        let gameScene = GameScene(size: view!.bounds.size)
        let transition = SKTransition.fadeWithDuration(10)
        view!.presentScene(gameScene, transition: transition)
        
    }
    
    private func addListeners() {
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: #selector(GameMenuScene.actOnButton(_:)), name: Constants.START_GAME_EASY, object: easyBtn)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: #selector(GameMenuScene.actOnButton(_:)), name: Constants.START_GAME_MEDIUM, object: medBtn)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: #selector(GameMenuScene.actOnButton(_:)), name: Constants.START_GAME_HARD, object: hardBtn)
    }
    
    @objc func actOnButton(notification: NSNotification) {
        print("NOTIFICATION: Difficulty Button pressed")
        if(notification.name == Constants.START_GAME_EASY){
            startGame()
        } else if (notification.name == Constants.START_GAME_MEDIUM){
            startGame()
        } else {
            startGame()
        }
    }

}