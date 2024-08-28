import UIKit

class Animal {
    let legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
    
    func speak() {
    }
}

class Dog: Animal {
    override func speak() {
        print("gav gav")
    }
}

class Cat: Animal {
    var isTame: Bool
    
    init(legs: Int, isTame: Bool) {
        self.isTame = isTame
        super.init(legs: legs)
    }
    
    override func speak() {
        print("meaw meaw")
    }
}

class Corgi: Dog {
    override func speak() {
        print("gav liake Corgi")
    }
}

class Poodle: Dog {
    override func speak() {
        print("gav like Poodle")
    }
}

class Persian: Cat {
    override func speak() {
        print("meaw like Persian")
    }
}

class Lion: Cat {
    override func speak() {
        print("meaw like Lion")
    }
}
