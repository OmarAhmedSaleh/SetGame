
import UIKit

class ViewController: UIViewController {
    var attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key: Any]()
    var chArray = [Character]()
    private var game = setGame()
    var numberOfSelectedButtons = 0
     var selectedCards = [Card]()
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet var buttons: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        startNewGame()
    }
    @IBAction func newGame(_ sender: Any) {
        startNewGame()
    }
    private func startNewGame(){
        removeButtons()
        game.createNewGame()
        updateScore()
        getCard(12)
    }
    private func removeButtons(){
        clearGlobalVariables()
        for btn in buttons{
            btn.setAttributedTitle(NSAttributedString(string: String(chArray),attributes: attributes), for: .normal)
            btn.backgroundColor = UIColor.black
            btn.layer.borderColor = UIColor.white.cgColor
        }
    }
    @IBAction func add3Cards(_ sender: Any) {
        getCard(3)
    }
    @IBAction func selectCard(_ sender: Any) {
        if numberOfSelectedButtons == 3{
            return
        }
        let button  = sender as! UIButton
        if button.layer.borderColor == UIColor.white.cgColor{
            button.layer.borderColor = UIColor.blue.cgColor
            button.layer.borderWidth = 4
            numberOfSelectedButtons += 1
            if numberOfSelectedButtons == 3{
                if checkSet(){
                     game.incScore()
                    removeCardsFromView()
                }else{
                    deselectCards()
                }
                numberOfSelectedButtons = 0
            }
        }else{
            numberOfSelectedButtons -= 1
            button.layer.borderColor = UIColor.white.cgColor
        }
    }
    private func deselectCards(){
        for btn in buttons{
            if btn.layer.borderColor == UIColor.blue.cgColor{
                btn.layer.borderColor = UIColor.white.cgColor
            }
        }
    }
    private func clearGlobalVariables(){
        attributes.removeAll()
        chArray.removeAll()
    }
    private func removeCardsFromView(){
        clearGlobalVariables()
        updateScore()
        for btn in buttons{
            if btn.layer.borderColor == UIColor.blue.cgColor{
                
                 btn.setAttributedTitle(NSAttributedString(string: String(chArray),attributes: attributes), for: .normal)
                btn.backgroundColor = UIColor.black
                btn.layer.borderColor = UIColor.white.cgColor
            }
        }
    }
    private func updateScore(){
        scoreLabel.text = "Score: \(game.score)"
    }
    private func checkSet() -> Bool{
       selectedCards.removeAll()
        for btn in buttons{
            if btn.layer.borderColor == UIColor.blue.cgColor{
                selectedCards.append(game.cards[btn.tag])
            }
        }
        var rules = [Bool]()
        rules.append((selectedCards[0].number == selectedCards[1].number && selectedCards[0].number == selectedCards[2].number) || (selectedCards[0].number != selectedCards[1].number && selectedCards[0].number != selectedCards[2].number && selectedCards[1].number != selectedCards[2].number))
        
        rules.append((selectedCards[0].look == selectedCards[1].look && selectedCards[0].look == selectedCards[2].look) || (selectedCards[0].look != selectedCards[1].look && selectedCards[0].look != selectedCards[2].look && selectedCards[1].look != selectedCards[2].look))
        
        rules.append((selectedCards[0].Shape == selectedCards[1].Shape && selectedCards[0].Shape == selectedCards[2].Shape) || (selectedCards[0].Shape != selectedCards[1].Shape && selectedCards[0].Shape != selectedCards[2].Shape && selectedCards[1].Shape != selectedCards[2].Shape))
        
        rules.append((selectedCards[0].color == selectedCards[1].color && selectedCards[0].color == selectedCards[2].color) || (selectedCards[0].color != selectedCards[1].color && selectedCards[0].color != selectedCards[2].color && selectedCards[1].color != selectedCards[2].color))
        
        return rules[0] && rules[1] && rules[2] && rules[3]
    }
    private func getCard(_ numberOfCards: Int){
        if game.cards.count == 0{
            moreBtn.isEnabled = false
        }
        for _ in 1...numberOfCards{
            let card = game.dealCard()
           clearGlobalVariables()
            checkShape(card.Shape)
            checkColor(card.color)
            checkLengthOfString(card.number + 1)
            checkLook(card.look)
            changeButtonLayout()
        }
    }
    private func changeButtonLayout(){
        for btn in buttons{
            if btn.backgroundColor == UIColor.black{
                btn.setAttributedTitle(NSAttributedString(string: String(chArray),attributes: attributes), for: .normal)
                btn.backgroundColor = .white
                btn.tag = game.currentCard - 1
                break
            }
        }
    }
    private func checkShape(_ shapeNumber: Int){
        switch shapeNumber{
            case 0: chArray.append("▲")
            case 1: chArray.append("●")
            case 2: chArray.append("■")
        default:
            return
        }
    }
    private func checkLook(_ Type: Int){
        let color = attributes[NSAttributedString.Key.foregroundColor] as! UIColor
        switch Type{
            case 0: attributes[NSAttributedString.Key.strokeWidth] = -10
            case 1: attributes[NSAttributedString.Key.strokeWidth] = 10
            case 2: attributes[NSAttributedString.Key.foregroundColor] = color.withAlphaComponent(0.15)
        default:
            return
        }
        
    }
    private func checkLengthOfString(_ Length: Int){
        for _ in 1..<Length {
            chArray.append(chArray[0])
        }
    }
    private func checkColor(_ colorNumber: Int){
        var color: UIColor?
        switch colorNumber{
            case 0: color = UIColor.red
            case 1: color = UIColor.green
            case 2: color = UIColor.blue
        default:
                return
        }
        attributes[NSAttributedString.Key.foregroundColor] = color
    }
}

