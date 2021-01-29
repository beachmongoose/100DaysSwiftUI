//
//  ContentView.swift
//  BucketListDemos
//
//  Created by Maggie Maldjian on 1/29/21.
//

import LocalAuthentication
import SwiftUI

struct ContentView: View {
  @State private var isUnlocked = false

  var body: some View {
    VStack {
      if self.isUnlocked {
        Text("Unlocked")
      } else {
        Text("Locked")
      }
    }.onAppear(perform: authenticate)
  }

  func authenticate() {
    let context = LAContext()
    var error: NSError?
  
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
      let reason = "We need to unlock your data."

      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
        DispatchQueue.main.async {
          if success {
            self.isUnlocked = true
          } else {
            //problem
          }
        }
      }
    } else {
      //no
    }
  }
}

struct MapContentView: View {
  var body: some View {
    MapView()
      .edgesIgnoringSafeArea(.all)
  }
}

enum LoadingState {
  case loading, success, failed
}

struct DifferentViewsView: View {
  var loadingState = LoadingState.loading
  var body: some View {
    Group {
      switch loadingState {
      case .loading:
        LoadingView()
      case .success:
        SuccessView()
      default:
        FailedView()
      }
    }
  }
}

struct LoadingView: View {
  var body: some View {
    Text("Loading...")
  }
}

struct SuccessView: View {
  var body: some View {
    Text("Success!")
  }
}

struct FailedView: View {
  var body: some View {
    Text("Failed.")
  }
}

struct ReadAndWriteView: View {
  var body: some View {
    Text("Hello, world!")
      .onTapGesture {
        let str = "Test Message"
        let url = Bundle.main.getDocumentsDirectory().appendingPathComponent("message.txt")
        do {
          try str.write(to: url, atomically: true, encoding: .utf8)
          let input = try String(contentsOf: url)
          print(input)
        } catch {
          print(error.localizedDescription)
        }
      }
  }
}

extension Bundle {
  func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

