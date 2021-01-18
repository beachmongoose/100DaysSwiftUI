//
//  ContentView.swift
//  Edutainment
//
//  Created by Maggie Maldjian on 1/18/21.
//

import SwiftUI

struct ContentView: View {
  @State var selectedValue = 1.0
  @State var isRunning = false
  var body: some View {
    VStack {
      if isRunning {
        GameView(range: selectedValue)
      } else {
        SettingsView(range: selectedValue)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
