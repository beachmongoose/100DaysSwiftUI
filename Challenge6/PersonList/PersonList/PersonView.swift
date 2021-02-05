//
//  AddPersonView.swift
//  PersonList
//
//  Created by Maggie Maldjian on 2/2/21.
//

import SwiftUI

struct PersonView: View {
  @State var person: Person
  @State private var firstName = ""
  @State private var lastName = ""
  @State private var image: UIImage?
    var body: some View {
      GeometryReader { geo in
        VStack {
          if image != nil {
            Image(uiImage: image!)
              .resizable()
              .scaledToFit()
              .frame(width: geo.size.width / 1.1, height: geo.size.width / 1.1)
          } else {
            DefaultRectangle()
              .frame(width: geo.size.width / 1.1, height: geo.size.width / 1.1)
          }
          Form {
            HStack {
              Text("First:")
                .fontWeight(.bold)
              TextField("Enter here", text: $firstName)
                .disabled(true)
            }
            HStack {
              Text("Last:")
                .fontWeight(.bold)
              TextField("Enter here", text: $lastName)
                .disabled(true)
            }
          }
        }
        .onAppear(perform: populateInfo)
      }
    }

  func populateInfo() {
    let manager = FileManager()
    firstName = person.firstName
    lastName = person.lastName
    let path = manager.getDocumentsDirectory().appendingPathComponent(person.image)
    image = UIImage(contentsOfFile: path.path)
  }
}

struct PersonView_Previews: PreviewProvider {
  static var person = Person(firstName: "Tetsuro", lastName: "Hoshino", image: "")
  static var previews: some View {
      PersonView(person: person)
    }
}
