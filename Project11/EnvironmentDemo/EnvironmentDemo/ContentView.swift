//
//  ContentView.swift
//  EnvironmentDemo
//
//  Created by Maggie Maldjian on 1/22/21.
//

import SwiftUI

struct ContentView: View {
  @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>
  @Environment(\.managedObjectContext) var moc
  var body: some View {
    VStack {
      List {
        ForEach(students, id: \.id) { student in
          Text(student.name ?? "Unknown")
        }
      }
      Button("Add") {
        let firstNames = ["Tetsuro", "Hiroshi", "Manabu", "Tadashi", "Susumu"]
        let lastNames = ["Hoshino", "Umino", "Yuuki", "Daiba", "Oki"]

        let chosenFirstName = firstNames.randomElement() ?? "Matsumoto"
        let chosenLastName = lastNames.randomElement() ?? "Leiji"

        let student = Student(context: self.moc)
        student.id = UUID()
        student.name = "\(chosenFirstName) \(chosenLastName)"

        try? self.moc.save()
      }
    }
  }
}

struct RememberButtonView: View {
  @State private var rememberMe = false
    var body: some View {
      VStack {
        PushButton(title: "Remember Me", isOn: $rememberMe)
        Text(rememberMe ? "On" : "Off")
      }
    }

  struct PushButton: View {
    let title: String
    @Binding var isOn: Bool

    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]

    var body: some View {
      Button(title) {
        self.isOn.toggle()
      }
      .padding()
      .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
      .foregroundColor(.white)
      .clipShape(Capsule())
      .shadow(radius: isOn ? 0 : 5)
    }
  }
}

struct SizeClassView: View {
  @Environment(\.horizontalSizeClass) var sizeClass
  var body: some View {
    if sizeClass == .compact {
      return AnyView(VStack {
        Text("Active size class:")
        Text("COMPACT")
      }
      .font(.largeTitle))
    } else {
      return AnyView(HStack {
        Text("Active size class:")
        Text("REGULAR")
      }
      .font(.largeTitle))
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
