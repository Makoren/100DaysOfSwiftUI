//
//  ContentView.swift
//  BucketList
//
//  Created by Luke Lazzaro on 23/11/21.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct AlertInfo: Identifiable {
    enum AlertType {
        case auth, noBiometrics
    }
    
    let id: AlertType
    let title: String
    let message: String
}

struct ContentView: View {
    @State private var isUnlocked = false
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false
    @State private var info: AlertInfo?

    var body: some View {
        ZStack {
            if isUnlocked {
                AppView(locations: $locations, showingPlaceDetails: $showingPlaceDetails, showingEditScreen: $showingEditScreen)
            } else {
                Button("Unlock Places") {
                    self.authenticate()
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                // error alerts
                .alert(item: $info) { info in
                    Alert(title: Text(info.title), message: Text(info.message), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // Touch ID reason is defined in code, Face ID reason is defined in Info.plist (which is the Info section of your project in Xcode 13)
            let reason = "Please authenticate yourself to unlock your places."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.info = AlertInfo(id: .auth, title: "Error", message: "Could not autheticate user.")
                    }
                }
            }
        } else {
            self.info = AlertInfo(id: .noBiometrics, title: "Error", message: "No biometric authentication on this device.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
