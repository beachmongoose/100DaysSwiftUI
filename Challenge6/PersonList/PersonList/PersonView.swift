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
  @State private var image: Image?
  @State private var inputImage: UIImage?
    var body: some View {
      GeometryReader { geo in
        VStack {
          Spacer(minLength: 100.00)
          ZStack {
            Rectangle()
              .fill(Color.secondary)
              .frame(width: geo.size.width / 1.1, height: geo.size.width / 1.1)
            if image != nil {
              image?
                .resizable()
                .scaledToFit()
            } else {
              Text("+ Add Image")
                .foregroundColor(.white)
                .font(.headline)
            }
          }
          .frame(maxWidth: .infinity, maxHeight: geo.size.height, alignment: .center)
          Form {
            HStack {
              Text("First:")
                .fontWeight(.bold)
              TextField("Enter here", text: $firstName)
            }
            HStack {
              Text("Last:")
                .fontWeight(.bold)
              TextField("Enter here", text: $lastName)
            }
          }
        }
        .onAppear(perform: populateInfo)
        .navigationTitle("Add Person")
        .navigationBarItems(trailing: Button("Save") {
          self.saveImage()
        })
      }
    }

  func saveImage() {
    
  }

  func populateInfo() {
    firstName = person.firstName
    lastName = person.lastName
  }
}

struct PersonView_Previews: PreviewProvider {
  static var person = Person(firstName: "Tetsuro", lastName: "Hoshino")
  static var previews: some View {
      PersonView(person: person)
    }
}
