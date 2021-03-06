//
//  ContentView.swift
//  WeSplit
//
//  Created by Maggie Maldjian on 1/11/21.
//

import SwiftUI

struct ContentView: View {
  @State private var checkAmount = ""
  @State private var numberOfPeople = ""
  @State private var tipPercentage = 2
  var totalAmount: Double {
    let tipSelection = Double(tipPercentages[tipPercentage])
    let orderAmount = Double(checkAmount) ?? 0

    let tipValue = orderAmount / 100 * tipSelection
    let grandTotal = orderAmount + tipValue

    return grandTotal
  }
  var totalPerPerson: Double {
    guard let peopleCount = Double(numberOfPeople) else { return 0 }
    return totalAmount / peopleCount
  }
  let tipPercentages = [10, 15, 20, 25, 0]
  

    var body: some View {
      NavigationView {
        Form {
          Section {
            TextField("Amount", text: $checkAmount)
              .keyboardType(.decimalPad)
            TextField("Number of people", text: $numberOfPeople)
              .keyboardType(.decimalPad)
          }
          Section(header: Text("How much tip do you want to leave?")) {
            Picker("Tip Percentage", selection: $tipPercentage) {
              ForEach(0..<tipPercentages.count) {
                Text("\(self.tipPercentages[$0])%")
              }
            }
            .pickerStyle(SegmentedPickerStyle())
          }
          Section(header: Text("Total amount")) {
            Text("$\(totalAmount, specifier: "%.2f")")
          }
          Section(header: Text("Amount per person")) {
            Text("$\(totalPerPerson, specifier: "%.2f")")
              .foregroundColor((tipPercentage == 4) ? .red : .black)
          }
        }
        .navigationTitle("WeSplit")
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
