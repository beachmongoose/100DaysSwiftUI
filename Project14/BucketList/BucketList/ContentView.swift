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
  @State private var showingEditScreen = false
  @State private var centerCoordinate = CLLocationCoordinate2D()
  @State private var locations = [CodableMKPointAnnotation]()
  @State private var selectedPlace: MKPointAnnotation?
  @State private var showingPlaceDetails = false
  var body: some View {
    ZStack {
      if isUnlocked {
        MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: locations)
          .edgesIgnoringSafeArea(.all)
        Circle()
          .fill(Color.blue)
          .opacity(0.3)
          .frame(width: 32, height: 32)
        VStack {
          Spacer()
          HStack {
            Spacer()
            Button(action: {
              let newLocation = CodableMKPointAnnotation()
              newLocation.title = "Example location"
              newLocation.coordinate = self.centerCoordinate
              self.locations.append(newLocation)
              self.selectedPlace = newLocation
              self.showingEditScreen = true
            }) {
              ButtonImage()
            }
          }
        }
      } else {
        Button("Unlock Places") {
          self.authenticate()
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .clipShape(Capsule())

      }
    }
    .onAppear(perform: loadData)
    .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
      if self.selectedPlace != nil {
        EditView(placemark: self.selectedPlace!)
      }
    }
    .alert(isPresented: $showingPlaceDetails) {
      Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Unknown place"), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
        self.showingEditScreen = true
      })
    }
  }

  func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }

  func loadData() {
    let fileName = getDocumentsDirectory().appendingPathComponent("SavedPlaces")

    do {
      let data = try Data(contentsOf: fileName)
      locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
      print("loaded!")
    } catch {
      print("Unable to load saved data.")
    }
  }

  func saveData() {
    do {
      let fileName = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
      let data = try JSONEncoder().encode(self.locations)
      try data.write(to: fileName, options: [.atomicWrite, .completeFileProtection])
      print("saved data")
    } catch {
      print("Unable to save data")
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
            // error
          }
        }
      }
    } else {
      // nope
    }
  }
}

struct ButtonImage: View {
  var body: some View {
    Image(systemName: "plus")
      .padding()
      .background(Color.black.opacity(0.75))
      .foregroundColor(.white)
      .font(.title)
      .clipShape(Circle())
      .padding(.trailing)
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
