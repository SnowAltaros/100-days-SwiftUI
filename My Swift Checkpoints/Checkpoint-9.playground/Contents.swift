import UIKit

func randomInt(numbers: [Int]?) -> Int { numbers?.randomElement() ?? Int.random(in: 1...100) }

func somecode(numbers: [Int?]?) -> Int {
    let random = Int.random(in: 1...100)
    return (numbers?.randomElement() ?? random) ?? random
}

// better version
func getNumber(in array: [Int?]?) -> Int {
    lazy var random = Int.random(in: 1...100)
    return (array?.randomElement() ?? random) ?? random
}
