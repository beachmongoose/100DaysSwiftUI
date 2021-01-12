//
//  ContentView.swift
//  UnitConverter
//
//  Created by Maggie Maldjian on 1/12/21.
//

import SwiftUI

struct ContentView: View {
  @State private var numberInput = ""
  @State private var unit1 = 0
  @State private var unit2 = 0
  var numberConverted: Double {
    guard let input = Double(numberInput) else { return 0 }
    guard unit1 != unit2 else { return input }
    let number = convertToCentimeters(input)
    return finalConversion(for: number)
  }

  func convertToCentimeters(_ input: Double) -> Double {
    switch unit1 {
    case 0:
      return Double(input * 100)
    case 1:
      return Double(input * 0.001)
    case 2:
      return Double(input * 2.54)
    case 3:
      return Double(input * 91.44007315213823972)
    case 4:
      return Double(input * 160934.4)
    default:
      return Double(input)
    }
  }

  func finalConversion(for input: Double) -> Double {
    switch unit2 {
    case 0:
    return Double(input * 0.01)
    case 1:
      return Double(input * 0.00001)
    case 2:
      return Double(input * 0.39370)
    case 3:
      return Double(input * 0.010936)
    case 4:
      return Double(input * 160934.4)
    default:
      return Double(input)
    }
  }
  
  let units = ["Meters", "Kilometers", "Inches", "Yards", "Miles", "Centimeters"]
  var body: some View {
    NavigationView {
      Form {
        Section {
          Picker("Unit Type", selection: $unit1) {
            ForEach(0..<units.count) {
              Text(units[$0])
            }
          }
          TextField("Enter number", text: $numberInput)
            .keyboardType(.decimalPad)
          Picker("Convert To", selection: $unit2) {
            ForEach(0..<units.count) {
              Text(units[$0])
            }
          }
          Text("\(numberConverted.removeZerosFromEnd())")
        }
      }
      .navigationTitle("UnitConverter")
    }
  }
}

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
