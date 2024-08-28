//
//  User.swift
//  SwiftDataProject
//
//  Created by Stanislav Popovici on 02/07/2024.
//

import Foundation
import SwiftData

@Model
class User {
    var name: String = "Anonumous"
    var city: String = "Unknown"
    var joinDate: Date = Date.now
    
    // if the User is deleted everything linked to this user will be deleted
    @Relationship(deleteRule: .cascade) var jobs: [Job]? = [Job]()
    
    var unwrappedJobs: [Job] {
        jobs ?? []
    }

    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}
