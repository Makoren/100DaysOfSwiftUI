//
//  ContentView.swift
//  ConsolidationDay77
//
//  Created by Luke Lazzaro on 2/12/21.
//

import SwiftUI

struct NamedImage: Codable, Identifiable {
    var id = UUID()
    var name: String
    var base64Image: String
    
    var image: UIImage {
        if let imageData = Data(base64Encoded: base64Image) {
            return UIImage(data: imageData) ?? UIImage()
        } else {
            print("Image cannot be converted from Base 64.")
            return UIImage()
        }
    }
}

struct ContentView: View {
    @State private var namedImages = [NamedImage]()
    @State private var showingNewImageSheet = false

    var body: some View {
        NavigationView {
            List(namedImages) { namedImage in
                NavigationLink(destination: ImageDetailView(namedImage: namedImage)) {
                    Text(namedImage.name)
                }
            }
            .navigationTitle("NameSaver")
            .toolbar {
                Button(action: {
                    self.showingNewImageSheet = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingNewImageSheet) {
                NewImageView(namedImages: $namedImages)
            }
        }
        .onAppear(perform: loadImages)
    }
    
    func loadImages() {
        let url = self.getDocumentsDirectory().appendingPathComponent("images.json")
        let json = (try? Data(contentsOf: url)) ?? Data()
        if let images = try? JSONDecoder().decode([NamedImage].self, from: json) {
            namedImages = images
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
