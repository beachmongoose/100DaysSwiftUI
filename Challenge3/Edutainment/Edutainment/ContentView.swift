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
          let rounds = Int(settings.problemAmount) ?? 145
          GameView(numberRange: settings.numberRange, totalRounds: rounds)
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
