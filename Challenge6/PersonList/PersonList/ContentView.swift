//
//  ContentView.swift
//  PersonList
//
//  Created by Maggie Maldjian on 2/2/21.
//

import SwiftUI

struct ContentView: View {
  private var images = ["keyboard", "hifispeaker.fill", "circle.fill", "printer.fill", "keyboard"]
  @State private var showingAddPerson = false
    var body: some View {
      NavigationView {
        GeometryReader { geo in
          List(images, id: \.self) { image in
            HStack(spacing: 20) {
              Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 55, height: 55)
              Text(image)
            }
          }
          .listStyle(PlainListStyle())
        }
        .sheet(isPresented: $showingAddPerson) {
          AddPersonView()
        }
        .navigationTitle(Text("PersonList"))
        .navigationBarItems(leading: EditButton(), trailing: Button(action: {
          self.showingAddPerson = true
        }) {
          Image(systemName: "plus")
        })
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
