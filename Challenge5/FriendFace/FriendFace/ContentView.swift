//
//  ContentView.swift
//  FriendFace
//
//  Created by Maggie Maldjian on 1/27/21.
//

import SwiftUI

struct ContentView: View {
  @State var mainIsActive: Bool = false
  @EnvironmentObject var userList: Users
  var body: some View {
    let users = userList.users
    NavigationView {
      List(users, id: \.id) { user in
        NavigationLink(destination: UserView(user: user, friends: users), isActive: $mainIsActive) {
          VStack(alignment: .leading) {
            Text(user.name)
              .font(.headline)
              .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Text(user.company)
            Text(user.email)
              .foregroundColor(.secondary)
          }
        }
      }
      .navigationTitle("FriendFace")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
