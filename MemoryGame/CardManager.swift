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
        initDeck()
        
    }
    
    private func initDeck() {
        
        for var i in (1...6) {
            card = Card(imageNamedFront: "c\(i).png", imageNamedBack: "c0.png")
            deck.append(card!)
            i += 1
        }
        
    }
    
    private func swapPositions(index1: Int, index2: Int) {
        var aux:Card?
        aux = deck[index1]
        deck[index1] = deck[index2]
        deck[index2] = aux!
    }
    
    func getDeck() -> [Card] {
        return deck
    }
    
    func getShuffledDeck() ->[Card] {
        shuffleDeck()
        return deck
    }
    
    func shuffleDeck() {
        
        var randIndex = 0
        
        for var i in (0 ... deck.count-1) {
            randIndex = Int(arc4random_uniform(UInt32(i+1)))
            swapPositions(randIndex, index2:Int(i))
            i += 1
        }
    }
}