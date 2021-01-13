//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Maggie Maldjian on 1/13/21.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    Text("Hello World")
      .blueTitle()
  }
}

struct BlueTitle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.largeTitle)
      .foregroundColor(.blue)
  }
}

extension View {
  func blueTitle() -> some View {
    self.modifier(BlueTitle())
  }
}

struct CustomContainerView: View {
  var body: some View {
    GridStack(rows: 4, columns: 4) { row, col in
      Image(systemName: "\(row * 4 + col).circle")
      Text("R\(row), C\(col)")
    }
  }
}

// can provide any kind of content: as long as conforms to View protocol
struct GridStack<Content: View>: View {
  let rows: Int
  let columns: Int
  let content: (Int, Int) -> Content

  var body: some View {
    VStack {
      ForEach(0..<rows, id: \.self) { row in
        HStack {
          ForEach(0..<self.columns, id: \.self) { column in
            self.content(row, column)
          }
        }
      }
    }
  }

  init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
    self.rows = rows
    self.columns = columns
    self.content = content
  }
}

struct FinalModifierView: View {
  var body: some View {
    Color.blue
      .frame(width: 300, height: 200)
      .watermarked(with: "Hacking with Swift")
  }
}

struct ModifierView: View {
  var body: some View {
    Text("Hello World")
      .titleStyle()
  }
}

extension View {
  func titleStyle() -> some View {
    self.modifier(Title())
  }
}

struct Title: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.largeTitle)
      .foregroundColor(.white)
      .padding()
      .background(Color.blue)
      .clipShape(RoundedRectangle(cornerRadius: 10))
  }
}

struct Watermark: ViewModifier {
  var text: String
  func body(content: Content) -> some View {
    ZStack(alignment: .bottomTrailing) {
      content
      Text(text)
        .font(.caption)
        .foregroundColor(.white)
        .padding(5)
        .background(Color.black)
    }
  }
}

extension View {
  func watermarked(with text: String) -> some View {
    self.modifier(Watermark(text: text))
  }
}

struct CompositionView: View {
  var body: some View {
    VStack(spacing: 10) {
      CapsuleText(text: "First")
        .foregroundColor(.white)
      CapsuleText(text: "Second")
        .foregroundColor(.yellow)
    }
  }
}

struct CapsuleText: View {
  var text: String

  var body: some View {
    Text(text)
      .font(.largeTitle)
      .padding()
      .background(Color.blue)
      .clipShape(Capsule())
  }
}

struct AsPropertiesView: View {
  let motto2 = Text("nunquam titillandus")
  var motto1: some View { Text("Draco dormiens") }
  var body: some View {
    VStack {
      motto1
      motto2
    }
  }
}

struct EnviroModifierView: View {
  var body: some View {
    VStack {
      Text("Adler")
        .blur(radius: 3)
      Text("Orca")
      Text("Lang")
    }
    .blur(radius: 2)
  }
}

struct ButtonView: View {
  var body: some View {
    Button("Hello World") {
      print(type(of: self.body))
    }
    .frame(width: 200, height: 200)
    .background(Color.red)
  }
}

struct PaddingView: View {
  var body: some View {
    Text("Hello World")
      .background(Color.red)
      .padding()
      .background(Color.blue)
      .padding()
      .background(Color.green)
      .padding()
      .background(Color.yellow)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ContentView()
    }
  }
}
