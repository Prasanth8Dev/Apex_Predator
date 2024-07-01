//
//  ContentView.swift
//  Apex Predators
//
//  Created by Prasanth S on 06/06/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let predator = Predators()
    @State var searchText = ""
    @State var isAlphabetical = false
    @State var currentSelection = PredatorsType.all
    @State var filteredMovie = ""
    
    var filteredData: [ApexPredatorModel] {
        predator.filterByMovie(movieName: filteredMovie)
        predator.sortBy(isAlphabetical: isAlphabetical)
        predator.filterBy(type: currentSelection)
        return predator.filterSearchData(searchText: searchText)
    }

    var body: some View {
        NavigationStack {
            List(filteredData) { dino in
                NavigationLink {
                    //Image(dino.image).resizable()
                    PredatorDetails(predratorData: dino, position: .camera(MapCamera(centerCoordinate: dino.location, distance: 3000)))
                } label: {
                    HStack {
                        Image(dino.image).resizable().scaledToFit().frame(width: 100,height: 100).shadow(color: .green, radius: 5)
                        VStack(alignment:.leading) {
                            Text(dino.name).fontWeight(.bold)
                            Text(dino.type.rawValue.capitalized).font(.subheadline).fontWeight(.semibold).padding(.horizontal,10).padding(.vertical,5).background(dino.type.backgroundColor).clipShape(.capsule)
                        }
                    }
                }
            }.navigationTitle("Apex Predator")
                .searchable(text: $searchText)
                .autocorrectionDisabled()
                .animation(.linear, value: searchText)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            withAnimation {
                                isAlphabetical.toggle()
                            }
                            
                        } label: {
                            Image(systemName: isAlphabetical ? "textformat" : "film").symbolEffect(.bounce, value: isAlphabetical)
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Picker("Filter",selection: $filteredMovie.animation()) {
                                ForEach(filteredData.flatMap { $0.movies }, id: \.self) { movie in
                                            Label(movie, systemImage: "movieclapper")
                                                
                                        }
//                                let allMovies = filteredData.flatMap { $0.movies }
//                                ForEach(allMovies) {
//                                    movie in
//                                    Label(movie, systemImage: "movieclapper")
//                                }
//                                ForEach(PredatorsType.allCases) {  type in
//                                    Label(type.rawValue.capitalized, systemImage: type.icon)
//                                }
                            }
                        }label: {
                            Image(systemName: "slider.vertical.3")
                        }
                    }
                }
            
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
