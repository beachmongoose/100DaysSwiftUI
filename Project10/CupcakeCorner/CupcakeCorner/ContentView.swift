//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Maggie Maldjian on 1/22/21.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var order = Order()
  var body: some View {
    NavigationView {
      Form {
        Section {
          Picker("Select your cake type", selection: $order.userOrder.type) {
            ForEach(0..<order.userOrder.types.count) {
              Text(order.userOrder.types[$0])
            }
          }

          Stepper(value: $order.userOrder.quantity, in: 3...20) {
            Text("Number of cakes: \(order.userOrder.quantity)")
          }
        }
        Section {
          Toggle(isOn: $order.userOrder.specialRequestEnabled.animation()) {
            Text("Any special requests?")
          }
          if order.userOrder.specialRequestEnabled {
            Toggle(isOn: $order.userOrder.extraFrosting) {
              Text("Add extra frosting")
            }
            Toggle(isOn: $order.userOrder.addSprinkles) {
              Text("Add extra sprinkles.")
            }
          }
        }
        Section {
          NavigationLink(destination: AddressView(order: order)) {
            Text("Delivery details")
          }
        }
      }
      .navigationBarTitle("Cupcake Corner")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
