//
//  MissionView.swift
//  Moonshot
//
//  Created by Maggie Maldjian on 1/20/21.
//

import SwiftUI

struct MissionView: View {
  let mission: Mission
  let astronauts: [CrewMember]
    var body: some View {
      GeometryReader { geometry in
        ScrollView(.vertical) {
          VStack {
            Image(self.mission.image)
              .resizable()
              .scaledToFit()
              .frame(maxWidth: geometry.size.width * 0.7)
              .accessibility(label: Text(mission.imageID))
              .accessibility(removeTraits: .isImage)
            Text("Launch Date: \(mission.formattedLaunchDate)")

            Text(self.mission.description)
              .padding()
              .layoutPriority(1)

            Spacer(minLength: 25)

            ForEach(self.astronauts, id: \.role) { crewMember in
              NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                HStack {
                  Image(decorative: crewMember.astronaut.id)
                    .resizable()
                    .frame(width: 83, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 15.0))
                    .overlay(RoundedRectangle(cornerRadius: 15.0).stroke(Color.primary, lineWidth: 1))
                  VStack(alignment: .leading) {
                    Text(crewMember.astronaut.name)
                      .font(.headline)
                    Text(crewMember.role)
                      .foregroundColor(.secondary)
                  }
                  .accessibilityElement(children: .combine)

                  Spacer()
                }
                .padding(.horizontal)
              }
              .buttonStyle(PlainButtonStyle())
            }
          }
        }
      }
      .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }

  struct CrewMember {
    let role: String
    let astronaut: Astronaut
  }

  init(mission: Mission, astronauts: [Astronaut]) {
    self.mission = mission

    var matches = [CrewMember]()

    for member in mission.crew {
      if let match = astronauts.first(where: {$0.id == member.name}) {
        matches.append(CrewMember(role: member.role, astronaut: match))
      } else {
        fatalError("Missing \(member)")
      }
    }
    self.astronauts = matches
  }
}

struct MissionView_Previews: PreviewProvider {
  static let missions: [Mission] = Bundle.main.decode("missions.json")
  static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
      MissionView(mission: missions[0], astronauts: astronauts)
    }
}
