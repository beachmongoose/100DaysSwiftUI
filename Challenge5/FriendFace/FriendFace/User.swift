//
//  User.swift
//  FriendFace
//
//  Created by Maggie Maldjian on 1/27/21.
//

import Foundation

struct User: Decodable, Identifiable {
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

  struct Friend: Decodable {
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

  var friendsList: [User] {
    let users = Users().users
    var matches = [User]()
    for friend in self.friends {
      if let match = users.first(where: {$0.id == friend.id}) {
        matches.append(match)
      }
    }
    return users
  }
}

extension Date {
  var stringDate: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter.string(from: self)
  }
}
