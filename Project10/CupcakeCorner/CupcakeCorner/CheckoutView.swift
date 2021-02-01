//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Maggie Maldjian on 1/22/21.
//

import SwiftUI

struct CheckoutView: View {
  @ObservedObject var order: Order
  @State private var alertTitle = ""
  @State private var alertMessage = ""
  @State private var showingAlert = false
  @State private var showError = false

  var body: some View {
    GeometryReader { geo in
      ScrollView {
        VStack {
          // Project 15 Challenge 1
          Image(decorative: "cupcakes")
            .resizable()
            .scaledToFit()
            .frame(width: geo.size.width)

          Text("Your total is $\(self.order.userOrder.cost, specifier: "%.2f")")
            .font(.title)
            .padding()
          Button("Place Order") {
            self.placeOrder()
          }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
      }
      .alert(isPresented: $showingAlert) {
        Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
      }
    }
  }

  func placeOrder() {
    guard let encoded = try? JSONEncoder().encode(order) else {
      print("Failed to encode order")
      return
    }
    let url = URL(string: "https://reqres.in/api/cupcakes")!
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.httpBody = encoded

    URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard let data = data else {
        showAlert(title: "Connection Error", message: "Unable to send order.")
        print("No data in response: \(error?.localizedDescription ?? "Unknown Error")")
        return
      }
      if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
        let confirmation = "Your order for \(decodedOrder.userOrder.quantity)x \(order.userOrder.types[decodedOrder.userOrder.type].lowercased()) cupcakes is on its way!"
        showAlert(title: "Thank you!", message: confirmation)
        print(alertMessage)
      } else {
        print("Invalid response from server")
      }
    }.resume()
  }

  func showAlert(title: String, message: String) {
    alertTitle = title
    alertMessage = message
    showingAlert = true
  }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
      CheckoutView(order: Order())
    }
}
