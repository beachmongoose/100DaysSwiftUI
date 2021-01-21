//
//  AddTaskView.swift
//  HabitTracker
//
//  Created by Maggie Maldjian on 1/21/21.
//

import SwiftUI

struct AddHabitView: View {
  @Environment(\.presentationMode) var presentationMode
  @State private var name = ""
  @State private var type = "Hobbies"
  @State private var times = "0"
  @State private var errorMessage = ""
  @ObservedObject var habitList: HabitList
  @State private var showingError = false

  static let types = ["Hobbies", "Business", "Errands", "Upkeep", "Misc"]

    var body: some View {
      NavigationView {
        Form {
          TextField("Name", text: $name)
          Picker("Type", selection: $type) {
            ForEach(Self.types, id: \.self) {
              Text($0)
            }
          }
          TextField("Times", text: $times)
            .keyboardType(.numberPad)
        }
        .navigationBarTitle("Add new Habit")
        .navigationBarItems(trailing: Button("Save") {
          validate()
        })
      }
      .alert(isPresented: $showingError) {
        Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
      }
    }

  func validate() {
    guard self.name != "" else { errorMessage = "Invalid name."
      showingError = true
      return
    }
    guard let convertedTimes = Int(self.times) else { errorMessage = "Invalid number."
      showingError = true
      return
    }
    if convertedTimes < 0 { errorMessage = "Invalid number."
      showingError = true
      return
    }
      let task = Habit(name: self.name, times: convertedTimes)
      self.habitList.tasks.append(task)
      self.presentationMode.wrappedValue.dismiss()
  }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
      AddHabitView(habitList: HabitList())
    }
}
