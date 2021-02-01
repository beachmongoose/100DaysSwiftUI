//
//  AstronautView.swift
//  Moonshot
//
//  Created by Maggie Maldjian on 1/20/21.
//

import SwiftUI

struct AstronautView: View {
  let astronaut: Astronaut
  let missionsDetail: [Mission] = Bundle.main.decode("missions.json")
  let missions: [String]
    var body: some View {
      GeometryReader { geometry in
        ScrollView(.vertical) {
          VStack {
            Image(decorative: self.astronaut.id)
              .resizable()
              .scaledToFit()
              .frame(width: geometry.size.width)

            Text(self.astronaut.description)
              .padding()
              .layoutPriority(1)
            VStack(alignment: .leading) {
              Text("Missions:")
                .padding(.leading)
                .font(.title2)
              List(missions, id: \.self) {
                Text($0)
              }
            }
          }
        }
      }
      .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }

  init(astronaut: Astronaut) {
    self.astronaut = astronaut
    var missionList = [String]()

    for mission in missionsDetail {
      for crew in mission.crew {
        if crew.name == astronaut.id {
          missionList.append(mission.displayName)
        }
      }
    }
    self.missions = missionList
  }
}

struct AstronautView_Previews: PreviewProvider {
  static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
  static let missions: [Mission] = Bundle.main.decode("missions.json")
    static var previews: some View {
      AstronautView(astronaut: astronauts[0])
    }
}
