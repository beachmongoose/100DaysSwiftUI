//
//  ContentView.swift
//  CoreDataProjectChallenge
//
//  Created by Maggie Maldjian on 1/26/21.
//

import SwiftUI

enum Name {
  case first, last, full
}

enum PredicateType {
  case beginsWith, endsWith, contains
}

struct ContentView: View {
  @Environment(\.managedObjectContext) var moc
  @State private var filterString = ""
  @State private var sortBy = Name.last
  @State private var ascending = true
  @State private var predicateName: Name = .last
  @State private var predicate: PredicateType = .beginsWith

  var body: some View {
    VStack(spacing: 10) {
      FilteredList(filter: filterString,
                   sortType: sortBy,
                   ascending: ascending,
                   predicateName: predicateName,
                   predicate: predicate)
      Button("Add Examples") {
        addExamples()
      }
      HStack(spacing: 20) {
        Button("First") {
          self.predicateName = .first
        }
        .disabled(self.predicateName == .first)
        Button("Last") {
          self.predicateName = .last
        }
        .disabled(self.predicateName == .last)
        Button("Full") {
          self.predicateName = .full
        }
        .disabled(self.predicateName == .full)
      }
      HStack(spacing: 20) {
        Spacer()
        Button("Begins with") {
          self.predicate = .beginsWith
        }
        .disabled(self.predicate == .beginsWith)
        Button("Ends with") {
          self.predicate = .endsWith
        }
        .disabled(self.predicate == .endsWith)
        Button("Contains") {
          self.predicate = .contains
        }
        .disabled(self.predicate == .contains)
        Spacer()
      }
      TextField("Filter", text: $filterString)
        .padding([.leading, .trailing], 50)
        .padding([.top, .bottom], 20)
      Button("By First Name \(arrow(of: .first))") {
        self.adjust(button: .first)
      }
      Button("By Last Name \(arrow(of: .last))") {
        self.adjust(button: .last)
      }
    }
  }
  
  func adjust(button: Name) {
    if self.sortBy == button {
      self.ascending.toggle()
    } else {
      self.sortBy = button
      self.ascending = true
    }
  }
  
  func arrow(of sort: Name) -> String {
    if self.sortBy != sort { return "▲" }
    return "\((ascending == true) ? "▼" : "▲")"
  }

  func addExamples() {
    let bruce = Singer(context: self.moc)
    bruce.firstName = "Bruce"
    bruce.lastName = "Springsteen"

    let jack = Singer(context: self.moc)
    jack.firstName = "Jack"
    jack.lastName = "Johnson"

    let courtney = Singer(context: self.moc)
    courtney.firstName = "Courtney"
    courtney.lastName = "Barnett"

    let whitney = Singer(context: self.moc)
    whitney.firstName = "Whitney"
    whitney.lastName = "Houston"

    let bruno = Singer(context: self.moc)
    bruno.firstName = "Bruno"
    bruno.lastName = "Mars"

    let bob = Singer(context: self.moc)
    bob.firstName = "Bob"
    bob.lastName = "Dylan"

    let elton = Singer(context: self.moc)
    elton.firstName = "Elton"
    elton.lastName = "John"

    try? self.moc.save()
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
