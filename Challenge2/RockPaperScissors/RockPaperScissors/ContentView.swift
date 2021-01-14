//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Maggie Maldjian on 1/14/21.
//

import SwiftUI

struct ContentView: View {
  @State private var moves = ["Rock", "Paper", "Scissors"]
  @State private var computerMove = Int.random(in: 0..<3)
  @State private var shouldWin = Bool.random()
  @State private var round = 1
  @State private var userScore = 0
  @State private var showFinalScore = false
    var body: some View {
      VStack {
          Text("Move played: \(moves[computerMove])")
            .font(.largeTitle)
            .padding()
        Text("Play move to " + (shouldWin ? "win" : "lose"))
        HStack(spacing: 20) {
          ForEach(0..<3) { number in
            Button(action: {
              self.buttonTapped(number)
            }) {
              ButtonStyle(move: moves[number])
            }
          }
        }
        .alert(isPresented: $showFinalScore) {
          Alert(title: Text("Game Over"), message: Text("Final Score:  \(userScore)"), dismissButton: .default(Text("New Game")) {
            self.resetGame()
          })
        }
      }
    }

  func buttonTapped(_ number: Int) {
    if number == computerMove { resetGame()
      return }
    let outcome = (number == computerMove + 1 ||
                    (computerMove == 2 && number == 0))
    if shouldWin == outcome { userScore += 1 }
    if round == 10 { showFinalScore = true
      return
    }
    resetGame()
  }

  func resetGame() {
    if round == 10 {
      round = 1
      userScore = 0
    } else { round += 1 }
    print(round)
    computerMove = Int.random(in: 0..<3)
    shouldWin = Bool.random()
  }
}

struct ButtonStyle: View {
  let move: String
  var body: some View {
    Text(move)
      .padding(5)
      .foregroundColor(Color.black)
      .background(
        RoundedRectangle(cornerRadius: 10)
          .stroke(lineWidth: 2)
          .foregroundColor(.black)
      )}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
