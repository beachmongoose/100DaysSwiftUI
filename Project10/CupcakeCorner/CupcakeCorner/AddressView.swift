//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Maggie Maldjian on 1/22/21.
//

import SwiftUI

struct AddressView: View {
  @ObservedObject var order: Order
  var body: some View {
    Form {
      Section {
        TextField("Name", text: $order.userOrder.name)
        TextField("Street Address", text: $order.userOrder.streetAddress)
        TextField("City", text: $order.userOrder.city)
        TextField("Zip", text: $order.userOrder.zip)
      }
      Section {
        NavigationLink(destination: CheckoutView(order: order)) {
          Text("Check out")
        }
      }
      .disabled(!order.userOrder.hasValidAddress)
    }
    .navigationBarTitle("Deliver details", displayMode: .inline)
  }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
      AddressView(order: Order())
    }
}
