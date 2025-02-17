//
//  PredatorMap.swift
//  Apex Predators
//
//  Created by Prasanth S on 24/06/24.
//

import SwiftUI
import MapKit

struct PredatorMap: View {
    let predators = Predators()
    
    @State var satellite = false
    @State var position: MapCameraPosition
    
    var body: some View {
        Map(position: $position) {
            ForEach(predators.apexPredatorModel) { predator in
                Annotation(predator.name, coordinate: predator.location) {
                    Image(predator.image).resizable().scaledToFit().frame(height: 100).shadow(color: .orange, radius: 5).scaleEffect(x: -1)
                }
            }
        }.mapStyle(satellite ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
            .overlay(alignment: .bottomTrailing) {
                Button {
                    satellite.toggle()
                }label: {
                    Image(systemName: satellite ? "globe.americas.fill" : "globe.americas").font(.largeTitle).imageScale(.large).padding(3)
                        .background(.ultraThickMaterial)
                        .clipShape(.rect(cornerRadius: 7))
                        .shadow(radius: 3)
                        .padding()
                }
            }
            .toolbarBackground(.automatic)
    }
}

#Preview {
    PredatorMap(position:.camera(MapCamera(centerCoordinate: Predators().apexPredatorModel[2].location, distance: 1000, heading: 250, pitch: 80))).preferredColorScheme(.dark)
}
