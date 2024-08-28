//
//  Result.swift
//  BucketList
//
//  Created by Stanislav Popovici on 22/07/2024.
//

import Foundation

struct Result: Codable {
    let query: Query
}

// store dictionary with page number
struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable, Comparable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
    var description: String {
        terms?["description"]?.first ?? "No further information"
    }
    
    
    // with this method we are sorting the pages by title
    static func <(lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
}
