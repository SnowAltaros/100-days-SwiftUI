import UIKit

protocol Building {
    var type: String { get }
    var rooms: Int { get set }
    var price: Int { get set }
    var nameAgent: String { get }
    
    func printSummary()
}

extension Building {
    func printSummary() {
        print("Talk to \(nameAgent) to buy this \(type) for £\(price)")
    }
}

struct House: Building {
    let type = "house"
    
    var rooms: Int
    
    var price: Int
    
    var nameAgent: String
    
    func printSummary() {
        print("")
    }
    
    
}

struct Office: Building {
    let type = "office"
    
    var rooms: Int
    
    var price: Int
    
    var nameAgent: String
    
    func printSummary() {
        print("")
    }
    
    
}
