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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sceneView = view as! SKView
        
        // sceneView.showsFPS = true
        // sceneView.showsNodeCount = true
        sceneView.ignoresSiblingOrder = true
        
        let scene = GameMenuScene(size: view.bounds.size)
        scene.scaleMode = .ResizeFill
        sceneView.presentScene(scene)
        
        /*
        super.viewDidLoad()
        let scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        
        skView.presentScene(scene)*/
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
