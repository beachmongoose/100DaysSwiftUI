//
//  MKPointAnnotation+ObservableObject.swift
//  BucketList
//
//  Created by Maggie Maldjian on 1/29/21.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
  public var wrappedTitle: String {
    get {
      self.title ?? "Unknown value"
    }
    set {
      title = newValue
    }
  }

  public var wrappedSubtitle: String {
    get {
      self.subtitle ?? "Unknown value"
    }
    set {
      subtitle = newValue
    }
  }
}
