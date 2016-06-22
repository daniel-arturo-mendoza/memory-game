//
//  CardGameEngine.swift
//  MemoryGame
//
//  Created by Daniel Mendoza on 13/06/2016.
//  Copyright © 2016 Daniel Mendoza. All rights reserved.
//

import Foundation
import CoreGraphics

class CardGameEngine {
    
    static let INSTANCE = CardGameEngine()
    
    var numOfCards = 6
    
    private var deckAllCards : [Card] = []
    private var card :  Card?
    
    private var card1 : Card?
    private var card2 : Card?
    
    private var difficulty: DifficultyEnum = DifficultyEnum.Easy
    
    init() {
        
        initDeck()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    /* Sets game difficulty */
    func configureGame(difficulty: DifficultyEnum) {
        
        self.difficulty = difficulty
    }
    
    /* Initializes the primary deck with ALL available cards in the game */
    private func initDeck() {
        
        for var i in (1...6) {
            card = Card(imageNamedFront: "c\(i).png", imageNamedBack: "c0.png")
            self.deckAllCards.append(card!)
            i += 1
        }
    }
    
    /* Swaps positions within a given deck */
    private func swapPositions(inout deck:[Card], index1: Int, index2: Int) {
        
        var cardAux:Card?
        
        cardAux = deck[index1]
        deck[index1] = deck[index2]
        deck[index2] = cardAux!
        
    }
    
    /* Returns the primary deck */
    func getDeck() -> [Card] {
        
        return self.deckAllCards
    }
    
    /* Returns the primary deck after shuffling */
    func getShuffledDeck() ->[Card] {
        
        shuffleDeck(&self.deckAllCards)
        return self.deckAllCards
    }
    
    /* Returns THE deck to be used in the GAME.
     * It contains tuples of cards shuffled within the deck.
     */
    func getShuffledDeckForGame() -> [Card] {
        var _card:Card?
        var _deck: [Card] = []
        var numOfPairs:Int
        
        // Define the number of cards tuples according the difficulty.
        if (self.difficulty == DifficultyEnum.Easy) {
            numOfPairs = 3
        } else if (self.difficulty == DifficultyEnum.Medium) {
            numOfPairs = 5
        } else {
            numOfPairs = 7
        }
        
        // Shuffling the primary deck.
        shuffleDeck(&self.deckAllCards)
        
        // ...then draw the first 'numOfPairs' cards
        for var i in (0 ... numOfPairs-1) {
            
            // Place the drawn card into a new deck
            _deck.append(self.deckAllCards[i])
            NSNotificationCenter.defaultCenter().addObserver(
                self, selector: #selector(CardGameEngine.actOnReveal(_:)), name: Constants.CARD_REVEAL_NOTIFY, object: self.deckAllCards[i])
            
            // Create a copy of the drawn card
            _card = Card(imageNamedFront: "\(self.deckAllCards[i].id)", imageNamedBack: "c0.png")
            NSNotificationCenter.defaultCenter().addObserver(
                self, selector: #selector(CardGameEngine.actOnReveal(_:)), name: Constants.CARD_REVEAL_NOTIFY, object: _card)
            
            // Place the copied card into the new deck
            _deck.append(_card!)
            i += 1
        }
        
        shuffleDeck(&_deck)
        
        return _deck
    }
    
    /* Shuffle the a given deck */
    func shuffleDeck(inout deck:[Card]) {
        
        var randIndex = 0
        for var i in (0 ... deck.count-1) {
            randIndex = Int(arc4random_uniform(UInt32(i)))
            //print("swapping \(deck[randIndex].name) and \(deck[i].name)")
            swapPositions(&deck, index1: randIndex, index2:Int(i))
            i += 1
        }
        
    }
    
    /* Keeps track of the allowed revealed cards. It can only be 2 at the same time.  */
    func canFlip(_card:Card) -> Int {
        
        var res:Int = -1
        synced(self) {
            if(self.card1 == nil){
                self.card1 = _card
                res = 1
            } else if(self.card2 == nil){
                self.card2 = _card
                res = 2
            }
        }
        return res
    }
    
    private func hideRevealedCards() {
        if(card1 != nil && card2 != nil) { //deffensive programming
            card1?.flip()
            card2?.flip()
            resetRevealedCards()
        }
    }
    
    private func resetRevealedCards() {
        card1 = nil
        card2 = nil
    }
    
    private func areRevealedCardsEqual() -> Bool{
        if(card1 == nil) {
            return false
        } else if(card2 == nil) {
            return false
        } else {
            return (card1?.isEqual(card2))!
        }
    }
    
    @objc func actOnReveal(notification: NSNotification) {
        print("NOTIFICATION: Card revealed")
        if(areRevealedCardsEqual()){
            print("CARDS ARE EQUAL!!!")
            resetRevealedCards()
        } else if(card1 != nil && card2 != nil){
            print("CARDS ARE DIFFERENT")
            
            delay(2.0) {
                self.hideRevealedCards()
            }
        }
    }
    
    func delay(delay: Double, closure: ()->()) {
        
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(),
            closure
        )
    }
    
    /* Synchronizes a block of code */
    private func synced(lock: CardGameEngine, closure: () -> ()) {
        
        objc_sync_enter(lock)
        closure()
        objc_sync_exit(lock)
    }
    
}