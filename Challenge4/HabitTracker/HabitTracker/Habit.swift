//
//  Task.swift
//  HabitTracker
//
//  Created by Maggie Maldjian on 1/21/21.
//

import Foundation

struct Habit: Codable, Identifiable {
  var id = UUID()
  var name: String
  var times: Int

  var timesAsText: String {
   return String(self.times)
  }
}

class HabitList: ObservableObject, Identifiable {
  @Published var tasks: [Habit] {
    didSet {
      let encoder = JSONEncoder()
      if let encoded = try? encoder.encode(tasks) {
        UserDefaults.standard.set(encoded, forKey: "Tasks")
      }
    }
  }
  init() {
    if let items = UserDefaults.standard.data(forKey: "Tasks") {
      let decoder = JSONDecoder()
      if let decoded = try? decoder.decode([Habit].self, from: items) {
        self.tasks = decoded
        return
      }
    }
    self.tasks = []
  }
}
