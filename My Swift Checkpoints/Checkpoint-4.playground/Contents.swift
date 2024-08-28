import UIKit

enum PosibleErrors: Error {
    case outOfBounds, noRoot
}

func sqrtRoot(of number: Int) throws -> Int {
    if number < 1 && number > 10_000 {
        throw PosibleErrors.outOfBounds
    }
    
    for i in 1...100 {
        if i * i == number {
            return i
        }
    }
    throw PosibleErrors.noRoot
}


do {
    let rootNumber = try sqrtRoot(of: 400)
    print("The square root is: \(rootNumber).")
} catch PosibleErrors.outOfBounds {
    print("The number you provided is less than 1 or bigger than 10.000")
} catch {
    print("Sorry, but there isn't root for number you provided")
} catch {
    print("There was an error.")
}
