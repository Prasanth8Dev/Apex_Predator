//
//  Predators.swift
//  Apex Predators
//
//  Created by Prasanth S on 06/06/24.
//

import Foundation


class Predators {
    var apexPredatorModel: [ApexPredatorModel] = []
    var allApexPredatorModel: [ApexPredatorModel] = []
    
    init() {
        decodePredatorData()
    }
    
    func decodePredatorData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // If we are created the property with snakeCase but it will contain with underScore
                apexPredatorModel = try decoder.decode([ApexPredatorModel].self, from: data)
                allApexPredatorModel = apexPredatorModel
            }catch(let err) {
                print(err)
            }
            
        }
    }
    
    func filterSearchData(searchText: String) -> [ApexPredatorModel] {
        if searchText.isEmpty {
            return apexPredatorModel
        } else {
            return apexPredatorModel.filter({ $0.name.localizedStandardContains(searchText)})
        }
    }
    
    func sortBy(isAlphabetical: Bool) {
        apexPredatorModel.sort { data1, data2 in
            if isAlphabetical {
                data1.name < data2.name
            } else {
                data1.id < data2.id
            }
        }
    }
    
    func filterBy(type: PredatorsType) {
        if type == .all {
           apexPredatorModel = allApexPredatorModel
        } else {
            apexPredatorModel = allApexPredatorModel.filter({ predator in
                predator.type == type
            })
        }
      
    }
    
    func filterByMovie(movieName: String) {
        apexPredatorModel = allApexPredatorModel.filter({ predator in
            predator.movies.contains(movieName)
        })
        
    }
    
}
