//
//  ContentView.swift
//  PersonList
//
//  Created by Maggie Maldjian on 2/2/21.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var peopleList: People
  @State private var showingAddPerson = false
    var body: some View {
      NavigationView {
        GeometryReader { geo in
          List() {
            ForEach(peopleList.people, id: \.id) { person in
              NavigationLink(destination: PersonView(person: person)) {
                HStack(spacing: 20) {
                  let image = person.imageID()
                  if image != nil {
                    Image(uiImage: image!)
                      .resizable()
                      .scaledToFit()
                      .frame(width: 55, height: 55)
                  } else {
                    DefaultRectangle()
                      .frame(width: 55, height: 55)
                  }
                  VStack {
                    Text(person.firstName)
                    Text(person.lastName)
                  }
                }
              }
            }
          }
          .listStyle(PlainListStyle())
        }
        .sheet(isPresented: $showingAddPerson) {
          AddPersonView()
        }
        .navigationTitle(Text("PersonList"))
        .navigationBarItems(leading: EditButton(), trailing: Button(action: {
          self.showingAddPerson = true
        }) {
          Image(systemName: "plus")
        })
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
