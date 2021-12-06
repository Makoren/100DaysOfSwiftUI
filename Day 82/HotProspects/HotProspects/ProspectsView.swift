//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Luke Lazzaro on 7/12/21.
//

import SwiftUI

enum FilterType {
    case none, contacted, uncontacted
}

struct ProspectsView: View {
    let filter: FilterType
    @EnvironmentObject var prospects: Prospects
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }

    var body: some View {
        NavigationView {
            List {
                // The computed property works, because the entire body property is reinvoked whenever that Prospects object changes, thus reinvoking the computed property in the process and getting the updated prospects.
                ForEach(filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        let prospect = Prospect()
                        prospect.name = "Luke Lazzaro"
                        prospect.emailAddress = "nunya@business.com"
                        self.prospects.people.append(prospect)
                    }) {
                        Image(systemName: "qrcode.viewfinder")
                        Text("Scan")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
