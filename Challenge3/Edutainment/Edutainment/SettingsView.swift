//
//  SettingsView.swift
//  Edutainment
//
//  Created by Maggie Maldjian on 1/18/21.
//

import SwiftUI

struct SettingsView: View {
  @State var range: Double
  var body: some View {
    VStack {
      Text("Select Multiplication Range:")
      Stepper(value: $range, in: 1...12, step: 1) {
        Text("\(range, specifier: "%g")")
      }
      Button("Start Game") {
        isRunning = true
      }
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
      SettingsView(range: 1.0)
    }
}
