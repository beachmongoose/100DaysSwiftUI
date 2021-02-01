//
//  ContentView.swift
//  BucketList
//
//  Created by Maggie Maldjian on 1/29/21.
//

import LocalAuthentication
import MapKit
import SwiftUI

struct ContentView: View {
  @State private var isUnlocked = false
  @State private var showErrorAlert = false
  var body: some View {
    ZStack {
      if isUnlocked {
        UserView()
      } else {
        Button(action: authenticate) {
          AuthenticateButton()
        }
        .alert(isPresented: $showErrorAlert) {
          Alert(title: Text("Error"), message: Text("Authentication error occurred."), dismissButton: .default(Text("OK")))
        }
      }
    }
  }

  func authenticate() {
    let context = LAContext()
    var error: NSError?

    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
      let reason = "Please authenticate yourself to unlock your places."

      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in

        DispatchQueue.main.async {
          if success {
            self.isUnlocked = true
          } else {
            self.showErrorAlert = true
          }
        }
      }
    } else {
      self.showErrorAlert = true
    }
  }
}

struct AuthenticateButton: View {
  var body: some View {
    Text("Unlock Places")
      .padding()
      .background(Color.blue)
      .foregroundColor(.white)
      .clipShape(Capsule())
  }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
