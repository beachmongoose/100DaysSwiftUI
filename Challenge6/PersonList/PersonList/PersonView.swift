//
//  AddPersonView.swift
//  PersonList
//
//  Created by Maggie Maldjian on 2/2/21.
//

import SwiftUI

struct PersonView: View {
  @EnvironmentObject var peopleList: People
  @State var person: Person
  @State private var firstName = ""
  @State private var lastName = ""
  @State private var editName = false
  @State private var showingSaveConfirmation = false
  @State private var image: UIImage?
    var body: some View {
      GeometryReader { geo in
          Form {
            if image != nil {
              Image(uiImage: image!)
                .resizable()
                .scaledToFit()
            } else {
              DefaultRectangle()
            }
            HStack {
              Text("First:")
                .fontWeight(.bold)
              TextField("Enter here", text: $firstName)
                .disabled(editName)
            }
            HStack {
              Text("Last:")
                .fontWeight(.bold)
              TextField("Enter here", text: $lastName)
                .disabled(editName)
            }
          }
          .alert(isPresented: $showingSaveConfirmation) {
            Alert(title: Text("Name updated"), dismissButton: .default(Text("OK")))
          }
          .navigationBarItems(trailing: Button("Save") {
            self.updatePerson()
          })
          
        .onAppear(perform: populateInfo)
      }
    }

  func updatePerson() {
    var updatedPerson = person
    updatedPerson.firstName = self.firstName
    updatedPerson.lastName = self.lastName
    if person.firstName == updatedPerson.lastName && person.firstName == updatedPerson.lastName {
      return
    }
    if let index = peopleList.people.firstIndex(where: { $0.id == updatedPerson.id }) {
      peopleList.people[index] = updatedPerson
    }
    FileManager().encode(people: peopleList.people)
    self.showingSaveConfirmation = true
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
