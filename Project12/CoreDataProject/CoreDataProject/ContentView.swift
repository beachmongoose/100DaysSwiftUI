//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Maggie Maldjian on 1/25/21.
//

import SwiftUI

struct ContentView: View {
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(entity: Country.entity(), sortDescriptors: []) var countries: FetchedResults<Country>
  var body: some View {
    VStack {
      List {
        ForEach(countries, id: \.self) { country in
          Section(header: Text(country.wrappedFullName)) {
            ForEach(country.candyArray, id: \.self) { candy in
              Text(candy.wrappedName)
            }
          }
        }
      }
      Button("Add") {
        let candy1 = Candy(context: self.moc)
        candy1.name = "Mars"
        candy1.origin = Country(context: self.moc)
        candy1.origin?.shortName = "UK"
        candy1.origin?.fullName = "United Kingdom"

        let candy2 = Candy(context: self.moc)
        candy2.name = "KitKat"
        candy2.origin = Country(context: self.moc)
        candy2.origin?.shortName = "UK"
        candy2.origin?.fullName = "United Kingdom"

        let candy3 = Candy(context: self.moc)
        candy3.name = "Twix"
        candy3.origin = Country(context: self.moc)
        candy3.origin?.shortName = "UK"
        candy3.origin?.fullName = "United Kingdom"

        let candy4 = Candy(context: self.moc)
        candy4.name = "Toblerone"
        candy4.origin = Country(context: self.moc)
        candy4.origin?.shortName = "CH"
        candy4.origin?.fullName = "Switzerland"
        
        try? self.moc.save()
      }
    }
  }
}

struct SingerView: View {
  @Environment(\.managedObjectContext) var moc
  @State private var lastNameFilter = "A"

  var body: some View {
    VStack {
      FilteredList(filter: lastNameFilter)
      Button("Add Examples") {
        let bruce = Singer(context: self.moc)
        bruce.firstName = "Bruce"
        bruce.lastName = "Springsteen"

        let jack = Singer(context: self.moc)
        jack.firstName = "Jack"
        jack.lastName = "Johnson"

        let courtney = Singer(context: self.moc)
        courtney.firstName = "Courtney"
        courtney.lastName = "Barnett"

        try? self.moc.save()
      }
      Button("Show B") {
        self.lastNameFilter = "B"
      }
      Button("Show S") {
        self.lastNameFilter = "S"
      }
    }
  }
}

struct ShipView: View {
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "universe == %@", "Leijiverse")) var ships: FetchedResults<Ship>
  // NSPredicates:
  // "universe IN %@", [array of universes]
  // "name BEGINSWITH %@", "letter"
  // "name BEGINSWITH %@", "letter ignoring case"
  // "name < %@" "starts with letter before LETTER"
  // all can be flipped using NOT as with !, and joined using AND as with &&

  var body: some View {
    VStack {
      List(ships, id: \.self) { ship in
        Text(ship.name ?? "Unknown Name")
      }
      Button("Add Examples") {
        let ship1 = Ship(context: self.moc)
        ship1.name = "Arcadia"
        ship1.universe = "Leijiverse"
        
        let ship2 = Ship(context: self.moc)
        ship2.name = "Queen Emeraldas"
        ship2.universe = "Leijiverse"
        
        let ship3 = Ship(context: self.moc)
        ship3.name = "White Base"
        ship3.universe = "Gundam"
        
        let ship4 = Ship(context: self.moc)
        ship4.name = "Argama"
        ship4.universe = "Gundam"

        try? self.moc.save()
      }
    }
  }
}

struct WizardView: View {
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>

  var body: some View {
    VStack {
      List(wizards, id: \.self) { wizard in
        Text(wizard.name ?? "Unknown")
      }
      Button("Add") {
        let wizard = Wizard(context: self.moc)
        wizard.name = "Lute"
      }
      Button("Save") {
        do {
          try self.moc.save()
        } catch {
          print(error.localizedDescription)
        }
      }
    }
  }
}

struct Student: Hashable {
  let name: String
}

struct StudentView: View {
  let students = [Student(name: "Susumu Kodai"), Student(name: "Daisuke Shima")]
  var body: some View {
    List(students, id: \.self) { student in
      Text(student.name)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
