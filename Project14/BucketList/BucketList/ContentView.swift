//
//  ContentView.swift
//  BucketList
//
//  Created by Maggie Maldjian on 1/29/21.
//

import MapKit
import SwiftUI

struct ContentView: View {
  @State private var showingEditScreen = false
  @State private var centerCoordinate = CLLocationCoordinate2D()
  @State private var locations = [MKPointAnnotation]()
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
            let newLocation = MKPointAnnotation()
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
    .sheet(isPresented: $showingEditScreen) {
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
