//
//  Person.swift
//  PersonList
//
//  Created by Maggie Maldjian on 2/2/21.
//

import UIKit

struct Person: Codable {
  var id = UUID()
  var firstName: String
  var lastName: String
  var image: String

  init(firstName: String, lastName: String, image: String) {
    self.firstName = firstName
    self.lastName = lastName
    self.image = image
  }

  func imageID() -> UIImage? {
    let manager = FileManager()
    let path = manager.getDocumentsDirectory().appendingPathComponent(self.image)
    return UIImage(contentsOfFile: path.path)
  }
}
