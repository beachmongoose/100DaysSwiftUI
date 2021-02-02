//
//  Person.swift
//  PersonList
//
//  Created by Maggie Maldjian on 2/2/21.
//

import Foundation

struct Person {
  var firstName: String
  var lastName: String
  var id: UUID

  init(firstName: String, lastName: String) {
    self.firstName = firstName
    self.lastName = lastName
    self.id = UUID()
  }
}
