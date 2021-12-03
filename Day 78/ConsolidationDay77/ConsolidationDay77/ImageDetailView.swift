//
//  ImageDetailView.swift
//  ConsolidationDay77
//
//  Created by Luke Lazzaro on 2/12/21.
//

import SwiftUI

struct ImageDetailView: View {
    var namedImage: NamedImage
    @State private var image: UIImage?

    var body: some View {
        VStack {
            Image(uiImage: namedImage.image)
                .resizable()
                .scaledToFit()
            .navigationTitle(namedImage.name)
            
            LocationDisplayView(location: namedImage.location)
        }
    }
}
