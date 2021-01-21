//
//  TaskView.swift
//  HabitTracker
//
//  Created by Maggie Maldjian on 1/21/21.
//

import SwiftUI

struct HabitView: View {
  @ObservedObject var habitList: HabitList
  var habit: Habit
  @State private var steps = 0
  var body: some View {
    NavigationView {
      Form {
        Stepper(value: $steps, in: 0...1000) {
          let end = (self.steps == 0 || steps > 1) ? "times" : "time"
          (Text("\(steps) \(end)"))
        }
      }
    }
    .navigationTitle(habit.name)
    .navigationBarItems(trailing: Button("Save") {
      saveChanges()
    })
    .onAppear(perform: getNumber)
  }

  func getNumber() {
    steps = habit.times
  }

  func saveChanges() {
    for item in 0..<habitList.tasks.count {
      if habitList.tasks[item].id == habit.id {
        var editItem = habitList.tasks[item]
        editItem.times = steps
        habitList.tasks[item] = editItem
      }
    }
  }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
      let habit = Habit(name: "Test", times: 1)
      HabitView(habitList: HabitList(), habit: habit)
    }
}