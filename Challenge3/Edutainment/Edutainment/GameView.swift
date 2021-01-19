//
//  GameView.swift
//  Edutainment
//
//  Created by Maggie Maldjian on 1/18/21.
//

import SwiftUI

struct GameView: View {
  @State private var allQuestions = [(Int, Int)]()
  @State private var currentProblem = (0, 0)
  var numberRange: Int
  @State private var round = 1
  @EnvironmentObject var settings: GameSettings
  @State private var showEndGameAlert = false
  var totalRounds: Int
  @State private var userAnswer = ""
  @State private var userScore = 0

    var body: some View {
      NavigationView {
        Form {
          VStack(alignment: .trailing) {
            Text("\(currentProblem.0)")
            Text("x \(currentProblem.1)")
          }
          .font(.largeTitle)
          .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
          TextField("Answer", text: $userAnswer, onCommit: checkAnswer)
            .keyboardType(.numberPad)
            .font(.largeTitle)
          Button("Exit") {
            settings.isRunning = false
          }
          .alert(isPresented: $showEndGameAlert) {
            Alert(title: Text("Quiz Complete!"), message: Text("Your final score is \(userScore)"), dismissButton: .default(Text("New Game")) {
              settings.isRunning = false
            })
          }
        }
        .multilineTextAlignment(.center)
        .navigationBarTitle(Text("Round \(round)"))
      }
      .onAppear(perform: getAllProblems)
    }

  func getAllProblems() {
    for num1 in 1...numberRange {
      for num2 in 1...12 {
        allQuestions.append((num1, num2))
      }
    }
    showProblem()
  }

  func showProblem() {
    userAnswer = ""
    let index = Int.random(in: 0..<allQuestions.count)
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
    if allQuestions.count == 0 || round == totalRounds {
      showEndGameAlert = true
      return
    }
    round += 1
    showProblem()
  }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
      GameView(numberRange: 1, totalRounds: 5)
        .environmentObject(GameSettings())
    }
}
