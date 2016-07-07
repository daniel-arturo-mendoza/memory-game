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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sceneView = view as! SKView
        
        // sceneView.showsFPS = true
        // sceneView.showsNodeCount = true
        sceneView.ignoresSiblingOrder = true
        
        menuScene = GameMenuScene(size: view.bounds.size)
        menuScene!.scaleMode = .ResizeFill
        sceneView.presentScene(menuScene)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: #selector(actOnDifficultySelection(_:)), name: Constants.START_GAME_EASY, object: menuScene)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: #selector(actOnDifficultySelection(_:)), name: Constants.START_GAME_MEDIUM, object: menuScene)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: #selector(actOnDifficultySelection(_:)), name: Constants.START_GAME_HARD, object: menuScene)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: #selector(showModal(_:)), name: Constants.GAME_MODAL_MENU, object: gameScene)
        
       }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    private func startGame(difficulty: DifficultyEnum) {
        CardGameEngine.INSTANCE.configureGame(difficulty)
        
        gameScene = GameScene(size: view!.bounds.size)
        let transition = SKTransition.fadeWithDuration(4)
        let _sceneView = view as! SKView
        
        _sceneView.ignoresSiblingOrder = true
        _sceneView.presentScene(gameScene!, transition: transition)
    }
    
    @objc func actOnDifficultySelection(notification: NSNotification) {
        print("NOTIFICATION: Difficulty Button pressed")
        
        if(notification.name == Constants.START_GAME_EASY){
            startGame(DifficultyEnum.EASY)
        } else if (notification.name == Constants.START_GAME_MEDIUM){
            startGame(DifficultyEnum.MEDIUM)
        } else {
            startGame(DifficultyEnum.HARD)
        }
    }
    
    @objc func showModal(notification: NSNotification) {
        print("Notification: TODO: Showing Modal Dialog")
        
        //Uncomment to show the modal dialog
        let modalViewController = ModalViewController()
        modalViewController.modalPresentationStyle = .OverCurrentContext
        presentViewController(modalViewController, animated: true, completion: nil)
    }
    
}
