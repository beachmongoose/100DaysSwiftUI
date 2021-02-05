//
//  Persons.swift
//  PersonList
//
//  Created by Maggie Maldjian on 2/2/21.
//

import Foundation
import SwiftUI

class People: ObservableObject {
  @Published var people = [Person]()

  init() {
    let decode: [Person] = FileManager().decode()
      self.people = decode
  }
}
