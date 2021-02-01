//
//  UserView.swift
//  BucketList
//
//  Created by Maggie Maldjian on 2/1/21.
//

import MapKit
import SwiftUI

struct UserView: View {
  @State private var showingEditScreen = false
  @State private var centerCoordinate = CLLocationCoordinate2D()
  @State private var locations = [CodableMKPointAnnotation]()
  @State private var selectedPlace: MKPointAnnotation?
  @State private var showingPlaceDetails = false
    var body: some View {
      ZStack {
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
    } catch {
      print("Unable to load saved data.")
    }
  }

  func saveData() {
    do {
      let fileName = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
      let data = try JSONEncoder().encode(self.locations)
      try data.write(to: fileName, options: [.atomicWrite, .completeFileProtection])
    } catch {
      print("Unable to save data")
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

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
