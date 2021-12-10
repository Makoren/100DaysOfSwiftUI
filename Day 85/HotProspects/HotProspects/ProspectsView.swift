//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Luke Lazzaro on 7/12/21.
//

import SwiftUI
import CodeScanner
import UserNotifications

enum TabViewScreen {
    case none, contacted, uncontacted
}

// most recent will require you to add a Date property to Prospect, which gets set to current time when the Prospect is created, then you can sort Dates hopefully
enum FilterType {
    case name, mostRecent
}

struct ProspectsView: View {
    @State private var isShowingScanner = false
    @State private var isShowingFilterOptions = false
    @State private var prospectsFilter: FilterType = .name

    let tabViewScreen: TabViewScreen
    
    @EnvironmentObject var prospects: Prospects
    
    var title: String {
        switch tabViewScreen {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch tabViewScreen {
        case .none:
            let people = prospects.people
            return filterProspects(people, by: prospectsFilter)
        case .contacted:
            let people = prospects.people.filter { $0.isContacted }
            return filterProspects(people, by: prospectsFilter)
        case .uncontacted:
            let people = prospects.people.filter { !$0.isContacted }
            return filterProspects(people, by: prospectsFilter)
        }
    }

    var body: some View {
        NavigationView {
            List {
                // The computed property works, because the entire body property is reinvoked whenever that Prospects object changes, thus reinvoking the computed property in the process and getting the updated prospects.
                ForEach(filteredProspects) { prospect in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                            Text(prospect.scanDateString)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        if tabViewScreen == .none && prospect.isContacted {
                            Image(systemName: "checkmark.circle")
                        }
                    }
                    .contextMenu {
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
                            self.prospects.toggle(prospect)
                        }
                        
                        if !prospect.isContacted {
                            Button("Remind Me") {
                                self.addNotification(for: prospect)
                            }
                        }
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.isShowingScanner = true
                    }) {
                        Image(systemName: "qrcode.viewfinder")
                        Text("Scan")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Filter") {
                        isShowingFilterOptions = true
                    }
                    .confirmationDialog("Select a filter type", isPresented: $isShowingFilterOptions, titleVisibility: .visible) {
                        Button("Name") {
                            prospectsFilter = .name
                        }
                        
                        Button("Most Recent") {
                            prospectsFilter = .mostRecent
                        }
                    }
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Luke Lazzaro\nnunya@biznus.com", completion: self.handleScan)
            }
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            
            self.prospects.add(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
//            var dateComponents = DateComponents()
//            dateComponents.hour = 9
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("sorry nothing")
                    }
                }
            }
        }
    }
    
    private func filterProspects(_ prospects: [Prospect], by filter: FilterType) -> [Prospect] {
        switch prospectsFilter {
        case .name:
            return prospects.sorted { $0.name < $1.name }
        case .mostRecent:
            return prospects.sorted { $0.scanDate.compare($1.scanDate) == .orderedDescending }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(tabViewScreen: .none)
    }
}
