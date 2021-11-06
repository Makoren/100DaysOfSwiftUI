//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Luke Lazzaro on 5/11/21.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    @State private var errorMessage = ""
    @State private var showingError = false

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is $\(self.order.data.cost, specifier: "%.2f")")
                        .font(.title)
                        .alert(isPresented: $showingError) {
                            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                        }
                        
                    Button("Place Order") {
                        self.placeOrder()
                    }
                    .padding()
                    .alert(isPresented: $showingConfirmation) {
                        Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
                    }
                }
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order.data) else {
            print("Failed to encode order.data")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                self.errorMessage = "Please check your internet connection."
                self.showingError = true
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Order.OrderData.self, from: data) {
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
            } else {
                print("Invalid response from server")
            }
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
