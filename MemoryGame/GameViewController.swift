//
//  GameViewController.swift
//  AnimationExercise
//
//  Created by Daniel Mendoza on 17/04/2016.
//  Copyright (c) 2016 Daniel Mendoza. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var menuScene: GameMenuScene?
    var gameScene: GameScene?
    
    var _modalViewController: ModalPopUpDialog?
    var _modalViewControllerGameOver: ModalPopUpGameOver?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sceneView = view as! SKView
        
        sceneView.ignoresSiblingOrder = true
        
        menuScene = GameMenuScene(size: view.bounds.size)
        menuScene!.scaleMode = .ResizeFill
        
        sceneView.presentScene(menuScene)
        
        addListeners()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    private func addListeners() {
        addMenuListeners(menuScene: menuScene!)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: #selector(showModal(_:)), name: Constants.GAME_MODAL_MENU, object: gameScene)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: #selector(showMenu(_:)), name: Constants.GAME_MENU, object: _modalViewController)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: #selector(showModalGameOver(_:)), name: Constants.GAME_END, object: _modalViewControllerGameOver)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: #selector(restartGame), name: Constants.RESTART_GAME, object: _modalViewControllerGameOver)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: #selector(nextLevel), name: Constants.NEXT_LEVEL, object: _modalViewControllerGameOver)
    }
    
    private func addMenuListeners(menuScene menuScene:GameMenuScene) {
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: #selector(actOnDifficultySelection(_:)), name: Constants.START_GAME_EASY, object: menuScene)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: #selector(actOnDifficultySelection(_:)), name: Constants.START_GAME_MEDIUM, object: menuScene)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: #selector(actOnDifficultySelection(_:)), name: Constants.START_GAME_HARD, object: menuScene)
    }
    
    private func startGame(difficulty: DifficultyEnum) {
        CardGameEngine.INSTANCE.configureGame(difficulty)
        
        gameScene = GameScene(size: view!.bounds.size)
        let transition = SKTransition.fadeWithDuration(4)
        let _sceneView = view as! SKView
        
        _sceneView.ignoresSiblingOrder = true
        _sceneView.presentScene(gameScene!, transition: transition)
    }
    
    @objc private func restartGame() {
        super.viewDidLoad()
        let sceneView = view as! SKView
        sceneView.ignoresSiblingOrder = true
        
        gameScene?.removeAllChildren()
        gameScene = GameScene(size: view.bounds.size)
        gameScene!.scaleMode = .ResizeFill
        let transition = SKTransition.fadeWithDuration(2)
        sceneView.presentScene(gameScene!, transition: transition)
    }
    
    @objc private func nextLevel() {
        super.viewDidLoad()
        let sceneView = view as! SKView
        sceneView.ignoresSiblingOrder = true
        
        let currentlevel: DifficultyEnum = CardGameEngine.INSTANCE.difficulty
        if(currentlevel == DifficultyEnum.EASY) {
            CardGameEngine.INSTANCE.configureGame(DifficultyEnum.MEDIUM)
        } else if(currentlevel == DifficultyEnum.MEDIUM) {
            CardGameEngine.INSTANCE.configureGame(DifficultyEnum.HARD)
        } else {
            CardGameEngine.INSTANCE.configureGame(DifficultyEnum.HARD)
        }
        
        gameScene?.removeAllChildren()
        gameScene = GameScene(size: view.bounds.size)
        gameScene!.scaleMode = .ResizeFill
        let transition = SKTransition.fadeWithDuration(2)
        sceneView.presentScene(gameScene!, transition: transition)
    }
    
    @objc private func showMenu(notification: NSNotification){
        let _sceneView = view as! SKView
        
        CardGameEngine.INSTANCE.configureGame(DifficultyEnum.EASY)
        
        let menuScene = GameMenuScene(size: view!.bounds.size)
        menuScene.scaleMode = .ResizeFill
        let transition = SKTransition.flipVerticalWithDuration(1)
        
        _sceneView.presentScene(menuScene, transition: transition)
        
        addMenuListeners(menuScene: menuScene)
        
    }
    
    @objc func actOnDifficultySelection(notification: NSNotification) {
        print("<GameViewController> Starting a new game. Difficulty: \(notification.name)")
        
        if(notification.name == Constants.START_GAME_EASY){
            startGame(DifficultyEnum.EASY)
        } else if (notification.name == Constants.START_GAME_MEDIUM){
            startGame(DifficultyEnum.MEDIUM)
        } else {
            startGame(DifficultyEnum.HARD)
        }
    }
    
    @objc func showModal(notification: NSNotification) {
        print("<GameViewController> Showing Modal Dialog")
        
        _modalViewController = ModalPopUpDialog()
        _modalViewController!.modalPresentationStyle = .OverCurrentContext
        presentViewController(_modalViewController!, animated: true, completion: nil)
    }
    
    @objc func showModalGameOver(notification: NSNotification) {
        print("<GameViewController> GAME ENDED! - Showing Modal Dialog Game Over")
        _modalViewControllerGameOver = ModalPopUpGameOver()
        _modalViewControllerGameOver!.modalPresentationStyle = .OverCurrentContext
        presentViewController(_modalViewControllerGameOver!, animated: true, completion: nil)
    }
    
}
