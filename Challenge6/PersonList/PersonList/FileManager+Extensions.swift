//
//  FileManager+Extensions.swift
//  PersonList
//
//  Created by Maggie Maldjian on 2/3/21.
//

import Foundation

extension FileManager {
  func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }

  func encode(people: [Person]) {
    let encoder = JSONEncoder()
    if let data = try? encoder.encode(people) {
      let url = self.getDocumentsDirectory().appendingPathComponent("people.json")
      do {
        try data.write(to: url)
      } catch {
        print(error.localizedDescription)
      }
    }
  }

  func decode() -> [Person] {
    let decoder = JSONDecoder()
    let url = self.getDocumentsDirectory().appendingPathComponent("people.json")

    guard let data = try? Data(contentsOf: url) else {
      return [Person]()
    }
    guard let loaded = try? decoder.decode([Person].self, from: data) else {
      return [Person]()
    }

    return loaded
  }
}
