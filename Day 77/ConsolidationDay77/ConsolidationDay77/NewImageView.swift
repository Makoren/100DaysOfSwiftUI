//
//  NewImageView.swift
//  ConsolidationDay77
//
//  Created by Luke Lazzaro on 2/12/21.
//

import SwiftUI

struct NewImageView: View {
    @Binding var namedImages: [NamedImage]

    @State private var name = ""
    @State private var selectedPhoto: UIImage?
    
    @State private var showingImagePicker = false
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            if let selectedPhoto = selectedPhoto {
                VStack {
                    Image(uiImage: selectedPhoto)
                        .resizable()
                        .scaledToFit()
                    
                    TextField("Enter a name:", text: $name)
                    
                    Button("Save Image", action: saveImage)
                        .padding(.vertical)
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
        
        let jpegString = selectedPhoto.jpegData(compressionQuality: 0.8)!.base64EncodedString()
        let namedImage = NamedImage(name: name, base64Image: jpegString)
        namedImages.append(namedImage)
        
        if let json = try? JSONEncoder().encode(namedImages) {
            let url = self.getDocumentsDirectory().appendingPathComponent("images.json")
            try! json.write(to: url)
            
            presentationMode.wrappedValue.dismiss()
        }
    }
}
