//
//  Order.swift
//  CupcakeCorner
//
//  Created by Stanislav Popovici on 28/06/2024.
//

import Foundation

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    // add property observer for this variable
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    var name = UserDefaults.standard.string(forKey: "name") ?? "" {
          didSet {
              UserDefaults.standard.setValue(name, forKey: "name")
          }
      }
    var streetAddress = UserDefaults.standard.string(forKey: "streetAddress") ?? "" {
        didSet {
            UserDefaults.standard.setValue(streetAddress, forKey: "streetAddress")
        }
    }
    var city = UserDefaults.standard.string(forKey: "city") ?? "" {
        didSet {
            UserDefaults.standard.setValue(city, forKey: "city")
        }
    }
    var zip = UserDefaults.standard.string(forKey: "zip") ?? "" {
        didSet {
            UserDefaults.standard.setValue(zip, forKey: "zip")
        }
    }
    
    var hasValidAddress: Bool {
        if name.whitespaces() || streetAddress.whitespaces() || city.whitespaces() || zip.whitespaces() {
            return false
        }
        
        return true
    }
    
    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity) * 2
        
        // complicated cakes cost more
        cost += Decimal(type) / 2
        
        // $1/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        // $0.5/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
}

extension String {
    func whitespaces() -> Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
