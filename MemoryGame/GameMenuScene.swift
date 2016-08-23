//
//  GameMenuScene.swift
//  MemoryGame
//
//  Created by Daniel Mendoza on 27/06/2016.
//  Copyright © 2016 Daniel Mendoza. All rights reserved.
//

import Foundation
import SpriteKit

class GameMenuScene: SKScene, GameNotificationProtocol {
    
    let modelName = UIDevice.currentDevice().modelName
    var backgroundMusic: AnyObject = ""
    let bgImage = SKSpriteNode(imageNamed: "main_title_300x108")
    
    var easyBtn:DifficultyButton?
    var medBtn:DifficultyButton?
    var hardBtn:DifficultyButton?
    
    //var gameScene: GameScene?
    
    override init(size: CGSize) {
        super.init(size: size)
        
        if #available(iOS 9.0, *) {
            backgroundMusic = SKAudioNode(fileNamed: "menu_bck_music.aac")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = (UIColor.whiteColor())
        
        addTitle()
        addButtons()
        addListeners()
        
        if #available(iOS 9, *) {
            addBackgroundMusic()
        }
    }
    
    private func addTitle() {
        bgImage.position = CGPointMake(self.size.width/2, (self.size.height/2)+160)
        self.addChild(bgImage)
    }
    
    @available(iOS 9, *)
    private func addBackgroundMusic() {
        //We wait one second before playing the background music to avoid
        //music overlap and buggy behaviour
        
        runAction(SKAction.waitForDuration(0.5), completion: {
            self.addChild(self.backgroundMusic as! SKAudioNode)
        })
    }
    
    private func addButtons() {
        easyBtn = DifficultyButton(image: "easy.png", setDifficultyAction: Constants.START_GAME_EASY)
        easyBtn!.position = CGPointMake(self.size.width/2 , self.size.height/2)
        
        medBtn = DifficultyButton(image: "medium.png", setDifficultyAction: Constants.START_GAME_MEDIUM)
        medBtn!.position = CGPointMake(self.size.width/2 , (self.size.height/2)-60)
        
        hardBtn = DifficultyButton(image: "hard.png", setDifficultyAction: Constants.START_GAME_HARD)
        hardBtn!.position = CGPointMake(self.size.width/2 , (self.size.height/2)-120)
        
        addChild(easyBtn!)
        addChild(medBtn!)
        addChild(hardBtn!)
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
        print("<GameMenuScene> Difficulty Button pressed. Notifying to GameViewController")
        
        if(notification.name == Constants.START_GAME_EASY){
            postNotificationName(Constants.START_GAME_EASY)
            //startGame(DifficultyEnum.EASY)
        } else if (notification.name == Constants.START_GAME_MEDIUM){
            postNotificationName(Constants.START_GAME_MEDIUM)
            //startGame(DifficultyEnum.MEDIUM)
        } else {
            postNotificationName(Constants.START_GAME_HARD)
        }
    }
    
    func postNotificationName (notificationName:String) {
        NSNotificationCenter.defaultCenter().postNotificationName(notificationName, object: self)
    }

}