//
//  EditView.swift
//  BucketList
//
//  Created by Maggie Maldjian on 1/29/21.
//

import MapKit
import SwiftUI

enum LoadingState {
  case loading, loaded, failed
}

struct EditView: View {
  @State private var loadingState = LoadingState.loading
  @State private var pages = [Page]()
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var placemark: MKPointAnnotation
    var body: some View {
      NavigationView {
        Form {
          Section {
            TextField("Place name", text: $placemark.wrappedTitle)
            TextField("Description", text: $placemark.wrappedSubtitle)
          }
          Section(header: Text("Nearby...")) {
            if loadingState == .loaded {
              List(pages, id: \.pageid) { page in
                Text(page.title)
                  .font(.headline)
                + Text(": ") +
                Text("Page description here")
                  .italic()
              }
            } else if loadingState = .loading {
              Text("Loading...")
            } else {
              Text("Please try again later.")
            }
          }
        }
        .navigationTitle("Edit place")
        .navigationBarItems(trailing: Button("Done") {
          self.presentationMode.wrappedValue.dismiss()
        })
      }
    }

  func fetchNearbyPlaces() {
    let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(placemark.coordinate.latitude)%7C\(placemark.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
    guard let url = URL(string: urlString) else {
      print("Bad URL: \(urlString)"))
      return
    }
  }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
      EditView(placemark: MKPointAnnotation.example)
    }
}
