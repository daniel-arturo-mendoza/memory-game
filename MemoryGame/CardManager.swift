//
//  CardManager.swift
//  MemoryGame
//
//  Created by Daniel Mendoza on 13/06/2016.
//  Copyright © 2016 Daniel Mendoza. All rights reserved.
//

import Foundation
import CoreGraphics

class CardManager {
    
    static let cardManagerSingleton = CardManager()
    
    private var deck : [Card] = []
    private var card :  Card?
    
    init() {
        initCards()
        
    }
    
    private func initCards() {
        
        for var i in (1...6) {
            card = Card(imageNamedFront: "c\(i).png", imageNamedBack: "c0.png")
            deck.append(card!)
            i += 1
        }
        
    }
    
    func getDeck() -> [Card] {
        return deck
    }
    
}