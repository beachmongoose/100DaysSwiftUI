//
//  ContentView.swift
//  AccessibilityDemo
//
//  Created by Maggie Maldjian on 2/1/21.
//

import SwiftUI

struct ControlValueView: View {
  @State private var estimate = 25.0
  @State private var rating = 3

  var body: some View {
    Stepper("Rate our services \(rating)/5", value: $rating, in: 1...5)
      .accessibility(value: Text("\(rating) out of 5"))
//    Slider(value: $estimate, in: 0...50)
//      .padding()
//      .accessibility(value: Text("\(Int(estimate))"))
  }
}

struct ContentView: View {
  let pictures = [
    "ales-krivec-15949",
    "galina-n-189483",
    "kevin-horstmann-141705",
    "nicolas-tissot-335096"
  ]

  let labels = [
    "Tulips",
    "Frozen tree buds",
    "Sunflowers",
    "Fireworks"
  ]

  @State private var selectedPicture = Int.random(in: 0...3)

  var body: some View {
    Image(pictures[selectedPicture])
      .resizable()
      .scaledToFit()
      .onTapGesture {
        self.selectedPicture = Int.random(in: 0...3)
    }
      .accessibility(label: Text(labels[selectedPicture]))
      .accessibility(addTraits: .isButton)
      .accessibility(removeTraits: .isImage)
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
