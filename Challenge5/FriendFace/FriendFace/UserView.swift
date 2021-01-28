//
//  UserView.swift
//  FriendFace
//
//  Created by Maggie Maldjian on 1/27/21.
//

import SwiftUI

struct UserView: View {
  var user: User
  var body: some View {
    VStack {
      HStack {
        Text(user.name)
          .font(.title)
        Spacer()
        
        Text((user.isActive) ? "Online" : "Offline" )
        Text("●")
          .foregroundColor((user.isActive) ? .green : .gray)
      }
      .padding()
      List {
        UserCell(title: "Age:", text: String(user.age))
        UserCell(title: "Company:", text: user.company)
        UserCell(title: "Email:", text: user.email)
        VStack(alignment: .leading, spacing: 8) {
          Text("About:")
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
          Text(user.about)
        }
        VStack(alignment: .leading) {
          Text("Friends:")
            .fontWeight(.bold)
        }
      }
    }
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
  @EnvironmentObject var users: Users
    static var previews: some View {
      UserView(user: Users().defaultUser)
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
