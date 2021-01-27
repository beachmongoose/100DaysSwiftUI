//
//  ContentView.swift
//  FriendFace
//
//  Created by Maggie Maldjian on 1/27/21.
//

import SwiftUI

struct ContentView: View {
  @State private var users = [User]()
  var body: some View {
    List(users, id: \.id) { user in
      VStack(alignment: .leading) {
        Text(user.name)
          .font(.headline)
          .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
        Text(user.company)
        Text(user.email)
      }
    }
    .onAppear(perform: loadData)
  }
  func loadData() {
    guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
      print("Invalid URL")
      return
    }
    let request = URLRequest(url: url)
    URLSession.shared.dataTask(with: request) { data, response, error in
      if let data = data {
        if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
          DispatchQueue.main.async {
            self.users = decodedResponse
          }
          return
        }
      }
      print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
    }.resume()
  }
}

struct ContentView_Previews: PreviewProvider {
//  let user = User(id: "hey", isActive: true, name: "Tetsuro Hoshino", age: 13, company: "SDF", email: "ironsonofthestars@gmail.com", about: "Passenger on the Galaxy Express 999", registered: "1978-11-10T01:47:18-00:00", tags: ["child", "warrior", "human"], friends: [])
    static var previews: some View {
        ContentView()
    }
}
