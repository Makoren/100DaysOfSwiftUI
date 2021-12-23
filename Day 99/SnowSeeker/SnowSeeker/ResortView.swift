//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Luke Lazzaro on 22/12/21.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    @State private var selectedFacility: Facility?
    
    @Environment(\.horizontalSizeClass) var sizeClass
    @EnvironmentObject var favorites: Favorites

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .topTrailing) {
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    
                    Text("Source: \(resort.imageCredit)")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 4)
                        .background(.black.opacity(0.7))
                        .clipShape(Capsule())
                        .offset(x: -5, y: 5)
                }

                Group {
                    HStack {
                        if sizeClass == .compact {
                            Spacer()
                            VStack { ResortDetailsView(resort: resort) }
                            VStack { SkiDetailsView(resort: resort) }
                            Spacer()
                        } else {
                            ResortDetailsView(resort: resort)
                            Spacer().frame(height: 0)
                            SkiDetailsView(resort: resort)
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                
                    Text(resort.description)
                        .padding(.vertical)

                    Text("Facilities")
                        .font(.headline)

                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            facility.icon
                                .font(.title)
                                .onTapGesture {
                                    selectedFacility = facility
                                }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
            }
            
            Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
                if favorites.contains(resort) {
                    favorites.remove(resort)
                } else {
                    favorites.add(resort)
                }
            }
            .padding()
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .alert(item: $selectedFacility) { facility in
            facility.alert
        }
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}
