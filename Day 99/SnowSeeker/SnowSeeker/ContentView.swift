//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Luke Lazzaro on 21/12/21.
//

import SwiftUI

enum SortTypes {
    case `default`, alphabetical, country
}

struct ContentView: View {
    @State private var resorts: [Resort] = Bundle.main.decode("resorts.json")
    @State private var sortType = SortTypes.default
    @State private var showingSortTypes = false
    
    @ObservedObject var favorites = Favorites()
    
    var sortedResorts: [Resort] {
        switch sortType {
        case .default:
            return resorts
        case .alphabetical:
            return resorts.sorted { $0.name < $1.name }
        case .country:
            return resorts.sorted { $0.country < $1.country }
        }
    }

    var body: some View {
        NavigationView {
            List(sortedResorts) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.black, lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    
                    if favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibilityLabel(Text("This is a favorite resort"))
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Resorts")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        showingSortTypes = true
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
            }
            
            WelcomeView()
        }
        .onAppear(perform: favorites.load)
        .environmentObject(favorites)
        .confirmationDialog("Sort Type Options", isPresented: $showingSortTypes) {
            Button("Default") { sortType = .default }
            Button("Alphabetical") { sortType = .alphabetical }
            Button("Country") { sortType = .country }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Select a sort type")
        }
    }
}

// if you want, you can use this to remove the slide over functionality on bigger phones in landscape
extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(.stack))
        } else {
            return AnyView(self)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
