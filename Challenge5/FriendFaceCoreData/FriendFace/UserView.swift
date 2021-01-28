//
//  UserView.swift
//  FriendFace
//
//  Created by Maggie Maldjian on 1/27/21.
//

import SwiftUI

struct UserView: View {
  @EnvironmentObject var userList: Users
  var user: User
  var friends: [User]
  var body: some View {
    VStack {
      HStack(){
        Text("●")
          .foregroundColor((user.isActive) ? .green : .gray)
        Text((user.isActive) ? "Online" : "Offline" )
        Spacer()
      }
      .padding(.leading, 20)
      .padding(.top, 10)
        List {
          UserCell(title: "Age:", text: String(user.age))
          UserCell(title: "Company:", text: user.company)
          UserCell(title: "Email:", text: user.email)
        VStack(alignment: .leading, spacing: 8) {
          Text("About:")
            .font(.title2)
            .fontWeight(.bold)
            Text(user.about)
          }
        Text("Friends:")
          .font(.title2)
          .fontWeight(.bold)
        ForEach(self.friends, id: \.id) { friend in
          NavigationLink(destination: UserView(user: friend, friends: userList.users)) {
            VStack(alignment: .leading) {
              Text(friend.name)
                .font(.headline)
                .fontWeight(.bold)
              Text(friend.company)
              Text(friend.email)
                .foregroundColor(.secondary)
            }
          }
        }
      }
    }
    .navigationTitle(Text(user.name))
    .navigationBarItems(trailing:
    Button("Home") {
      self.userList.moveToMain = true
    })
  }

  init(user: User, friends: [User]) {
    self.user = user
    var matches = [User]()
    for friend in user.friends {
      if let match = friends.first(where: {$0.id == friend.id}) {
        matches.append(match)
      }
    }
    self.friends = matches
  }
}

struct UserCell: View {
  var title: String
  var text: String
  var body: some View {
    HStack(spacing: 20) {
      Text(title)
        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
      Spacer()
      Text(text)
    }
  }
}

struct UserView_Previews: PreviewProvider {
  static var users = Users()
  static var previews: some View {
      UserView(user: users.defaultUser, friends: users.users)
    }
}

//let id: String
//let isActive: Bool
//let name: String
//let age: Int
//let company: String
//let email: String
//let about: String
//let registered: String
//let tags: [String]
//let friends: [Friend]
