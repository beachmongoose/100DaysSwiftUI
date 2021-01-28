//
//  Users.swift
//  FriendFace
//
//  Created by Maggie Maldjian on 1/27/21.
//

import SwiftUI
import Foundation

class Users: ObservableObject {
  @Published var users = [User]()
  @Published var moveToMain: Bool = false

  init() {
    guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
      print("Invalid URL")
      return
    }
    let request = URLRequest(url: url)
    URLSession.shared.dataTask(with: request) { data, response, error in
      if let data = data {
        if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
            DispatchQueue.main.async { [weak self] in
              self?.users = decodedResponse
            }
          return
        }
      }
      print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
    }.resume()
  }

  var defaultUser: User {
    return User(id: "hey", isActive: true,
                name: "Tetsuro Hoshino", age: 13,
                company: "SDF", email: "ironsonofthestars@gmail.com",
                about: "Passenger on the Galaxy Express 999", registered: "1978-11-10T01:47:18-00:00",
                tags: ["child", "warrior", "human"], friends: [])
  }
}
