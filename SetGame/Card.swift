

import Foundation


enum Color: Int{
    case Red = 0
    case Blue = 1
    case Green = 2
}

enum Shape: Int{
    case C = 0
    case T = 1
    case R = 2
}

enum Look: Int{
    case Striped = 0
    case outline = 1
    case filled = 2
}

struct Card{
    var number: Int
    var look: Int
    var Shape: Int
    var color: Int
}
