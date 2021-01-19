//
//  SetupData.swift
//  Edutainment
//
//  Created by Maggie Maldjian on 1/19/21.
//

import Foundation

class GameSettings: ObservableObject {
  @Published var isRunning = false
  @Published var numberRange = 1
  @Published var problemAmount = "5"
}
