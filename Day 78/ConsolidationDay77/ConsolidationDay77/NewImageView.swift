//
//  NewImageView.swift
//  ConsolidationDay77
//
//  Created by Luke Lazzaro on 2/12/21.
//

import SwiftUI
import MapKit

struct NewImageView: View {
    @Binding var namedImages: [NamedImage]

    @State private var name = ""
    @State private var selectedPhoto: UIImage?
    @State private var location: CLLocationCoordinate2D?
    
    @State private var showingImagePicker = false
    @State private var showingNameErrorAlert = false
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            if let selectedPhoto = selectedPhoto {
                VStack {
                    Image(uiImage: selectedPhoto)
                        .resizable()
                        .scaledToFit()
                    
                    TextField("Enter a name:", text: $name)
                    
                    NewLocationView(location: $location)
                    
                    Button("Save Image", action: saveImage)
                        .padding(.vertical)
                        .alert(isPresented: $showingNameErrorAlert) {
                            Alert(title: Text("Please enter a name!"), message: Text("Enter a name so you don't forget who this person is."), dismissButton: .default(Text("OK")))
                        }
                }
                .padding()
            }
            
            Spacer()
        
            Button("Select Photo") {
                self.showingImagePicker = true
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $selectedPhoto)
            }
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    func saveImage() {
        guard let selectedPhoto = selectedPhoto else { return }
        guard !name.isEmpty else {
            self.showingNameErrorAlert = true
            return
        }
        
        let jpegString = selectedPhoto.jpegData(compressionQuality: 0.8)!.base64EncodedString()
        let namedImage = NamedImage(name: name, base64Image: jpegString, location: location ?? CLLocationCoordinate2D(latitude: 51.509865, longitude: -0.118092))
        namedImages.append(namedImage)
        
        if let json = try? JSONEncoder().encode(namedImages) {
            let url = self.getDocumentsDirectory().appendingPathComponent("images.json")
            try! json.write(to: url)
            
            presentationMode.wrappedValue.dismiss()
        }
    }
}
