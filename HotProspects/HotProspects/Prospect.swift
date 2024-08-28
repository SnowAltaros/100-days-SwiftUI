//
//  Prospect.swift
//  HotProspects
//
//  Created by Stanislav Popovici on 02/08/2024.
//

import SwiftData
import SwiftUI

@Model
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    var addedDate = Date.now
    
    
    init(name: String, emailAddress: String, isContacted: Bool) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
    }
}
