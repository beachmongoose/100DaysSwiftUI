//
//  User.swift
//  FriendFace
//
//  Created by Maggie Maldjian on 1/27/21.
//

import Foundation

struct User: Codable, Identifiable {
  let id: String
  let isActive: Bool
  let name: String
  let age: Int
  let company: String
  let email: String
  let about: String
  let registered: String
  let tags: [String]
  let friends: [Friend]

  struct Friend: Codable {
    let id: String
    let name: String
  }

  var registeredAsDate: Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    guard let date = formatter.date(from: self.registered) else { return Date() }
    return date
  }

  var shortDate: String {
    return registeredAsDate.stringDate
  }
}

extension Date {
  var stringDate: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter.string(from: self)
  }
}
