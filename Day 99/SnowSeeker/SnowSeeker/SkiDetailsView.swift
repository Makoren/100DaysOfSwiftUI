//
//  SkiDetailsView.swift
//  SnowSeeker
//
//  Created by Luke Lazzaro on 22/12/21.
//

import SwiftUI

struct SkiDetailsView: View {
    let resort: Resort

    var body: some View {
        Group {
            // Layout priority is needed, otherwise the text will wrap. This is because SwiftUI considers the spacer to be higher priority than the text.
            Text("Elevation: \(resort.elevation)m").layoutPriority(1)
            Spacer().frame(height: 0)
            Text("Snow: \(resort.snowDepth)cm").layoutPriority(1)
        }
    }
}

struct SkiDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SkiDetailsView(resort: Resort.example)
    }
}
