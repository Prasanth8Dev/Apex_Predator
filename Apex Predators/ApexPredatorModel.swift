//
//  ApexPredatorModel.swift
//  Apex Predators
//
//  Created by Prasanth S on 06/06/24.
//

import Foundation
import SwiftUI
import MapKit

struct ApexPredatorModel: Decodable, Identifiable {
    let id: Int
    let name: String
    let type: PredatorsType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    var image: String {
        return name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    struct MovieScene: Decodable, Identifiable{
        let id: Int
        let movie: String
        let sceneDescription: String
        
    }
}
    
enum PredatorsType: String, Decodable, CaseIterable, Identifiable {
    case all
    case air
    case land
    case sea
    case movie
    
    var id: PredatorsType {
        self
    }
    
    var backgroundColor: Color {
        switch self {
        case .air:
                .teal
        case .land:
                .brown
        case .sea:
                .blue
        case .all:
                .black
        case .movie:
                .clear
        }
    }
    
    var icon: String {
        switch self {
        case .all:
            "square.stack.3d.up.fill"
        case .air:
            "leaf.fill"
        case .land:
            "wind"
        case .sea:
            "drop.fill"
        case .movie:
            "movieclapper"
        }
    }
}
