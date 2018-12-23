
import Foundation

struct setGame{
    private(set) var cards = [Card]()
    private(set) var currentCard = 0
    private(set) var score = 0
     mutating func incScore(){
        score += 3
    }
    private mutating func CreateDeck(){
        for c in 0...2{
            for s in 0...2{
                for l in 0...2{
                    for n in 0...2{
                        let card = Card(number: n,look: l , Shape: s , color: c)
                        cards.append(card)
                    }
                }
            }
        }
        shuffleCards()
    }
    private mutating func shuffleCards(){
        for index in cards.indices{
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            let temp = cards[index]
            cards[index] = cards[randomIndex]
            cards[randomIndex] = temp
        }
    }
    mutating func dealCard() -> Card{
        currentCard += 1
        return cards[currentCard - 1]
        
    }
   mutating func createNewGame(){
    currentCard = 0
    score = 0
    shuffleCards()
    }
    init(){
        createNewGame()
         CreateDeck()
    }
}
