//
//  SettingsView.swift
//  Edutainment
//
//  Created by Maggie Maldjian on 1/18/21.
//

import SwiftUI

struct SettingsView: View {
  @EnvironmentObject var settings: GameSettings
  var problemRange = ["5", "10", "20", "All"]
  var body: some View {
    Form {
      VStack {
        Text("Select Multiplication Range:")
        Stepper(value: $settings.numberRange, in: 1...12) {
          let number = String(settings.numberRange)
          Text("\(number)")
        }
        Text("Select Number of Problems:")
        Picker("Number of Problems", selection: $settings.problemAmount) {
          ForEach(problemRange, id: \.self) {
            Text("\($0)")
          }
        }
        .pickerStyle(SegmentedPickerStyle())
        Button("Start Game") {
          self.settings.isRunning = true
        }
      }
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
      SettingsView()
        .environmentObject(GameSettings())
    }
}
