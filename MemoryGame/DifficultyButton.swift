//
//  DifficultyButton.swift
//  MemoryGame
//
//  Created by Daniel Mendoza on 28/06/2016.
//  Copyright © 2016 Daniel Mendoza. All rights reserved.
//

import Foundation
import SpriteKit

class DifficultyButton: Button {
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(image: String, setDifficultyAction: String) {
        super.init(image: image)
        self.action = setDifficultyAction
    }
    

}