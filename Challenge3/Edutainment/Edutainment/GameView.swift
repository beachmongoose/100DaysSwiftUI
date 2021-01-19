//
//  GameView.swift
//  Edutainment
//
//  Created by Maggie Maldjian on 1/18/21.
//

import SwiftUI

struct GameView: View {
  @State private var userScore = 0
  @State private var allQuestions = [(Int, Int)]()
  @State private var currentProblem = (0, 0)
  @State private var round = 1
  @State var totalRounds = 5
  @State private var userAnswer = ""
  @State private var showEndGameAlert = false
  @EnvironmentObject var settings: GameSettings
    var body: some View {
      Form {
        VStack(alignment: .trailing) {
          Text("\(currentProblem.0)")
          Text("x \(currentProblem.1)")
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        TextField("Answer", text: $userAnswer, onCommit: checkAnswer)
          .keyboardType(.numberPad)
        .alert(isPresented: $showEndGameAlert) {
          Alert(title: Text("Quiz Complete!"), message: Text("Your final score is \(userScore)"), dismissButton: .default(Text("New Game")) {
            settings.isRunning = false
          })
        }
      }
      .multilineTextAlignment(.center)
      .onAppear(perform: getAllProblems)
    }

  func getAllProblems() {
    totalRounds = Int(settings.problemAmount) ?? 0
    let range = Int(settings.numberRange)
    for num1 in 1...range {
      for num2 in 1...12 {
        allQuestions.append((num1, num2))
      }
    }
    showProblem()
  }

  func showProblem() {
    guard (!allQuestions.isEmpty) || totalRounds != round else {
      endGame()
      return
    }
    userAnswer = ""
    let index = Int.random(in: 0...allQuestions.count)
    let numbers = allQuestions[index]
    currentProblem = (numbers.0, numbers.1)
    allQuestions.remove(at: index)
  }

  func checkAnswer() {
    let correctAnswer = currentProblem.0 * currentProblem.1
    let userInput = Int(userAnswer) ?? 0
    if userInput == correctAnswer {
      userScore += 1
    }
    round += 1
    showProblem()
  }

  func endGame() {
    //show game over alert and score
  }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
      GameView()
        .environmentObject(GameSettings())
    }
}
