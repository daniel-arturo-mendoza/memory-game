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
    
    var _modalViewController: ModalViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sceneView = view as! SKView
        
        // sceneView.showsFPS = true
        // sceneView.showsNodeCount = true
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
        
        _modalViewController = ModalViewController()
        _modalViewController!.modalPresentationStyle = .OverCurrentContext
        presentViewController(_modalViewController!, animated: true, completion: nil)
    }
    
}
