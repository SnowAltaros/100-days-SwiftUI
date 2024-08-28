import UIKit

struct Car {
    let model: String
    let seats: Int
    private(set) var gear = 1
    let maxGears: Int
    
    mutating func myChangeGear(newGear: Int) {
        if newGear > 1 && newGear <= maxGears {
            gear = newGear
        }
    }
    
    mutating func paulChangeGear(difference: Int) {
        gear = gear + difference
        
        if gear < 1 {
            gear = 1
        } else if gear > maxGears {
            gear = maxGears
        }
    }
}

var car = Car(model: "Toyota", seats: 5, maxGears: 6)
car.myChangeGear(newGear: 4)
print(car.gear)
