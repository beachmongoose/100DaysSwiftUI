//
//  ContentView.swift
//  HabitTracker
//
//  Created by Maggie Maldjian on 1/21/21.
//

import SwiftUI

struct ContentView: View {
  @State private var showAddTask = false
  @ObservedObject var habitList = HabitList()
    var body: some View {
      NavigationView {
        List {
          ForEach(habitList.tasks) { habit in
            NavigationLink(destination: HabitView(habitList: self.habitList, habit: habit)) {
              HStack() {
                Text(habit.name)
                  .font(.headline)
                Spacer()
                Text(habit.timesAsText)
              }
            }
          }
          .onDelete(perform: removeItems)
        }
        .navigationBarTitle("HabitTracker")
        .navigationBarItems(leading: EditButton(), trailing: Button(action: {
          self.showAddTask = true
        }) {
          Image(systemName: "plus")
        })
        .sheet(isPresented: $showAddTask) {
          AddHabitView(habitList: self.habitList)
        }
      }
    }

  func removeItems(at offsets: IndexSet) {
    habitList.tasks.remove(atOffsets: offsets)
  }

  func addHabit() {
  let habit = Habit(name: "Test", times: 1)
  habitList.tasks.append(habit)
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
