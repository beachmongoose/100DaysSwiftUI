//
//  MapView.swift
//  BucketList
//
//  Created by Maggie Maldjian on 1/29/21.
//

import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
  func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
    let mapView = MKMapView()
    mapView.delegate = context.coordinator
    let annotation = makeAnnotation(title: "London", subtitle: "Capital of England", lat: 51.5, long: 0.13)
    mapView.addAnnotation(annotation)
    return mapView
  }

  func updateUIView(_ uiView: MKMapView, context: Context) {
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  func makeAnnotation(title: String, subtitle: String, lat: Double, long: Double) -> MKPointAnnotation {
    let annotation = MKPointAnnotation()
    annotation.title = title
    annotation.subtitle = subtitle
    annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
    return annotation
  }

  class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapView

    init(_ parent: MapView) {
      self.parent = parent
    }

    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
      print(mapView.centerCoordinate)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
      view.canShowCallout = true
      return view
    }
  }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

