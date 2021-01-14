//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Maggie Maldjian on 1/13/21.
//

import SwiftUI

struct ContentView: View {
  @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
  @State private var correctAnswer = Int.random(in: 0...2)
  @State private var showingScore = false
  @State private var scoreTitle = ""
  @State private var userScore = 0
  @State private var round = 1
  var body: some View {
    ZStack {
      LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
        .edgesIgnoringSafeArea(.all)
      VStack(spacing: 30) {
        VStack {
          Text("Tap the flag of")
            .foregroundColor(.white)
          Text(countries[correctAnswer])
            .font(.largeTitle)
            .fontWeight(.black)
            .foregroundColor(.white)
        }
        ForEach(0..<3) { number in
          Button(action: {
            self.flagTapped(number)
          }) {
            FlagImage(image: self.countries[number])
          }
        }
        Text("Score: \(userScore)")
          .foregroundColor(.white)
          .fontWeight(.black)
        Spacer()
      }
      .alert(isPresented: $showingScore) {
        Alert(title: Text(scoreTitle), message: Text("Your score is \(userScore)"), dismissButton: .default(Text((round < 10) ? "Continue" : "New Game")) {
          self.askQuestion()
        })
      }
    }
  }

  func flagTapped(_ number: Int) {
    let isCorrect: Bool = number == correctAnswer
    if isCorrect { userScore += 1 }
    scoreTitle = (isCorrect) ? "Correct" : "Wrong! That is the flag of \(countries[number])."
    showingScore = true
  }

  func askQuestion() {
    if round == 10 {
      round = 0
      userScore = 0
    } else { round += 1 }
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
  }
}

struct FlagImage: View {
    let image: String
    var body: some View {
      Image(image)
        .renderingMode(.original)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.black, lineWidth: 1))
        .shadow(color: .black, radius: 2)
    }
  }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
