//
//  ContentView.swift
//  iExpenseDemos
//
//  Created by Maggie Maldjian on 1/19/21.
//

import SwiftUI

// Codable Demo
struct CodableView: View {
  @State private var user = CodableUser(firstName: "Tetsuro", lastName: "Hoshino")

  var body: some View {
    Button("Save User") {
      let encoder = JSONEncoder()
      if let data = try? encoder.encode(self.user) {
        UserDefaults.standard.set(data, forKey: "UserData")
      }
    }
  }
}

struct CodableUser: Codable {
  var firstName: String
  var lastName: String
}

// UserDefaults Demo
struct ContentView: View {
  @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
  var body: some View {
    Button("Tap count: \(tapCount)") {
      self.tapCount += 1
      UserDefaults.standard.set(self.tapCount, forKey: "Tap")
    }
  }
}

// onDelete Demo
struct DeleteView: View {
  @State private var numbers = [Int]()
  @State private var currentNumber = 1

  var body: some View {
    VStack {
      List {
        ForEach(numbers, id: \.self) {
          Text("\($0)")
        }
        .onDelete(perform: removeRows)
      }
      Button("Add number") {
        self.numbers.append(self.currentNumber)
        self.currentNumber += 1
      }
    }
  }

  func removeRows(at offsets: IndexSet) {
    numbers.remove(atOffsets: offsets)
  }
}

// Sheet Demo
struct FirstView: View {
  @State private var showingSheet = false

  var body: some View {
    Button("Show Sheet") {
      self.showingSheet.toggle()
    }
    .sheet(isPresented: $showingSheet) {
      SecondView(name: "Tetsuro")
    }
  }
}

struct SecondView: View {
  var name: String
  @Environment(\.presentationMode) var presentationMode
  var body: some View {
    Text("Hello, \(name)!")
    Button("Dismiss") {
      self.presentationMode.wrappedValue.dismiss()
    }
  }
}


// Observable Objects Demo
class User: ObservableObject {
  @Published var firstName = "Tetsuro"
  @Published var lastName = "Hoshino"
}

struct ObservingView: View {
  @ObservedObject var user = User()
    var body: some View {
      VStack {
        Text("Your name is \(user.firstName) \(user.lastName).")

        TextField("First Name", text: $user.firstName)
        TextField("Last Name", text: $user.lastName)
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

