//
//  ContentView.swift
//  Moonshot
//
//  Created by Maggie Maldjian on 1/20/21.
//

import SwiftUI

struct ContentView: View {
  let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
  let missions: [Mission] = Bundle.main.decode("missions.json")
  @State private var showDates = true
    var body: some View {
      NavigationView {
        List(missions) { mission in
          NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
            Image(mission.image)
              .resizable()
              .scaledToFit()
              .frame(width: 44, height: 44)

            VStack(alignment: .leading) {
              Text(mission.displayName)
                .font(.headline)
              Text(showDates ? mission.formattedLaunchDate : mission.crewList)
            }
          }
        }
        .navigationBarTitle("Moonshot")
        .navigationBarItems(trailing:
                              Button(buttonTitle()) {
                                showDates.toggle()
                              })
      }
    }
  func buttonTitle() -> String {
    return showDates ? "Show Crew" : "Show Dates"
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
