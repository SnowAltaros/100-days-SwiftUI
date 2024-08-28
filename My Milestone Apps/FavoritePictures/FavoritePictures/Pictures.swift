//
//  Pictures.swift
//  FavoritePictures
//
//  Created by Stanislav Popovici on 31/07/2024.
//

import Foundation
import MapKit
import SwiftUI


struct PictureItem: Identifiable, Equatable, Codable, Hashable, Comparable {
    var id = UUID()
    var name: String
    var imageData: Data
    var latitude: Double
    var longitude: Double
    
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    
    func getImage(from data: Data) -> Image {
        guard let uiImage = UIImage(data: data) else { return Image(systemName: "photo")}
        return Image(uiImage: uiImage)
    }
    
    static func <(lhs: PictureItem, rhs: PictureItem) -> Bool {
            return lhs.name < rhs.name
    }
    
    
    // example data in our struct to be used in preview
    // wraped to be used just for testing and not going to app store
#if DEBUG
    static let example = PictureItem(id: UUID(), name: "Favorite Picture", imageData: Data(), latitude: 51.501, longitude: -0.141)
#endif
    
}

@Observable
class Pictures {
    let savePath = URL.documentsDirectory.appending(path: "SavedPictures")
    
    var items = [PictureItem]() {
        didSet {
            do {
                let data = try JSONEncoder().encode(items)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data")
            }
        }
    }
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            items = try JSONDecoder().decode([PictureItem].self, from: data)
        } catch {
            items = []
        }
    }
    
}
