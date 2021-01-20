//
//  ContentView.swift
//  MoonshotDemos
//
//  Created by Maggie Maldjian on 1/20/21.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    Button("Decode JSON") {
      let input = """
      {
        "name": "Taylor Swift",
        "address": {
          "street": "555, Taylor Swift Avenue",
          "city": "Nashville"
        }
      }
      """
      let data = Data(input.utf8)
      let decoder = JSONDecoder()
      if let user = try? decoder.decode(User.self, from: data) {
        print(user.address.street)
      }
    }
  }
}

struct User: Codable {
  var name: String
  var address: Address
}

struct Address: Codable {
  var street: String
  var city: String
}

struct LinkView: View {
  var body: some View {
    NavigationView {
      List(0..<100) { row in
        NavigationLink(destination: Text("Detail \(row)")) {
          Text("Row \(row)")
        }
      }
      .navigationBarTitle("SwiftUI")
    }
  }
}

// creates all immediately when using ScrollView and VStack
// creates as you scroll when using List
struct ScrollingView: View {
  var body: some View {
    ScrollView(.vertical) {
      VStack(spacing: 10) {
        ForEach(0..<100) {
          Text("Item \($0)")
            .font(.title)
        }
      }
      .frame(maxWidth: .infinity)
    }
  }
}

struct CustomText: View {
  var text: String
  var body: some View {
    Text(text)
  }

  init(_ text: String) {
    print("Creating a new CustomText")
    self.text = text
  }
}

struct ImageView: View {
  var body: some View {
    VStack {
      GeometryReader { geo in
        Image("20201102_134016")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: geo.size.width)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
