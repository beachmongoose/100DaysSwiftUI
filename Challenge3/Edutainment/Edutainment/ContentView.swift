//
//  ContentView.swift
//  Edutainment
//
//  Created by Maggie Maldjian on 1/18/21.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var settings: GameSettings
  var body: some View {
    Group {
      VStack {
        if settings.isRunning {
          GameView()
        } else {
          SettingsView()
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
          .environmentObject(GameSettings())
    }
}
