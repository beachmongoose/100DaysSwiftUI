//
//  Mission.swift
//  Moonshot
//
//  Created by Maggie Maldjian on 1/20/21.
//

import Foundation

struct Mission: Codable, Identifiable {
  struct CrewRole: Codable {
    let name: String
    let role: String
  }

  let id: Int
  let launchDate: Date?
  let crew: [CrewRole]
  let description: String

  var displayName: String {
    "Apollo \(id)"
  }
  var image: String {
    "apollo\(id)"
  }
  var imageID: String

  var formattedLaunchDate: String {
    if let launchDate = launchDate {
      let formatter = DateFormatter()
      formatter.dateStyle = .long
      return formatter.string(from: launchDate)
    } else {
      return "N/A"
    }
  }

  var crewList: String {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    var matches = [String]()

    for member in self.crew {
      if let match = astronauts.first(where: {$0.id == member.name}) {
        matches.append(match.name)
      } else {
        fatalError("Missing \(member)")
      }
    }
    return matches.joined(separator: ", ")
  }
}
