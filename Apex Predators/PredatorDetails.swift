//
//  PredatorDetails.swift
//  Apex Predators
//
//  Created by Prasanth S on 12/06/24.
//

import SwiftUI
import MapKit

struct PredatorDetails: View {
    let predratorData: ApexPredatorModel
    @State var position: MapCameraPosition
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    Image(predratorData.type.rawValue).resizable().scaledToFit().overlay {
                        LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.8),Gradient.Stop(color: .black, location: 1)], startPoint: .top, endPoint: .bottom)
                    }
                    Image(predratorData.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/1.5, height: geo.size.height/3) // resize the image based on device size
                        .scaleEffect(x: -1) // flip the image
                        .shadow(color: .cyan, radius: 10)
                        .offset(y:20) // change the image position
                }
                VStack(alignment:.leading){
                    //Dino Name
                    Text(predratorData.name).font(.largeTitle)
                    //Map Area
                    
                    //appears In
                    
                    Text("Appears In:").font(.title3)
                    ForEach(predratorData.movies, id: \.self) { movie in
                        Text("‣"+movie).font(.subheadline)
                    }
                    NavigationLink {
                        PredatorMap(position: .camera(MapCamera(centerCoordinate: predratorData.location, distance: 1000, heading: 250, pitch: 80)))
                    } label: {
                        Map(position: $position) {
                            Annotation(predratorData.name, coordinate: predratorData.location) {
                                Image(systemName: "mappin.and.ellipse").font(.largeTitle).imageScale(.large)
                                    .symbolEffect(.pulse)
                            }.annotationTitles(.hidden)
                        }.frame(height: 150)
                            .clipShape(.rect(cornerRadius: 10))
                            .overlay(alignment: .trailing) {
                                Image(systemName: "greaterthan").imageScale(.large)
                                    .font(.title3)
                                    .padding(.trailing,5)
                            }
                            .overlay(alignment: .topLeading) {
                                Text("Current Location")
                                    .padding([.leading,.bottom],5)
                                    .background(.black.opacity(0.33))
                                    .clipShape(.rect(cornerRadius: 10))
                            }
                    }
                    
                    
                    Text("Movie Moments").font(.title).padding(.top,10)
                    
                    ForEach(predratorData.movieScenes) { scene in
                        Text(scene.movie).font(.title2).padding(.vertical,5)
                        Text(scene.sceneDescription).padding(.bottom,10)
                    }
                    Text("Read More:").font(.caption).fontWeight(.semibold)
                    Link(predratorData.link, destination: URL(string: predratorData.link)!)
                    
                    
                }.padding()
                    .padding(.bottom,20)
                .frame(width: geo.size.width, alignment: .leading)
                    
            }.ignoresSafeArea()
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    PredatorDetails(predratorData: Predators().apexPredatorModel[10], position: .camera(MapCamera(centerCoordinate: Predators().apexPredatorModel[10].location, distance: 3000))).preferredColorScheme(.dark)
}
