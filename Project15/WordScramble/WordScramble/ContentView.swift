//
//  ContentView.swift
//  WordScramble
//
//  Created by Maggie Maldjian on 1/15/21.
//

import SwiftUI

struct ContentView: View {
  @State private var usedWords = [String]()
  @State private var rootWord = ""
  @State private var newWord = ""
  @State private var playerScore = 0

  @State private var errorTitle = ""
  @State private var errorMessage = ""
  @State private var showingError = false
  let pointsList =
    [1: ["a", "e", "i", "o", "u", "l", "n", "s", "t", "r"],
     2: ["d", "g"],
     3: ["b", "c", "m", "p"],
     4: ["f", "h", "v", "w", "y"],
     5: ["k"],
     8: ["j", "x"],
     10: ["q", "z"]]

  var body: some View {
    NavigationView {
      VStack {
        TextField("Enter your word", text: $newWord, onCommit: addNewWord)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .autocapitalization(.none)
          .padding()
        List(usedWords, id: \.self) { word in
          HStack {
            Image(systemName: "\(word.count).circle")
            Text(word)
          }
          .accessibilityElement(children: .ignore)
          .accessibility(label: Text("\(word), \(word.count) letters"))
        }
        Text("Score: \(playerScore)")
        Spacer()
      }
      .navigationBarTitle(rootWord)
      .navigationBarItems(trailing:
                            Button(action: startGame) {
                              Text("New Game")
                            })
      .onAppear(perform: startGame)
      .alert(isPresented: $showingError) {
        Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
      }
    }
  }

  func startGame() {
    if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
      if let startWords = try? String(contentsOf: startWordsURL) {
        let allWords = startWords.components(separatedBy: "\n")
        rootWord = allWords.randomElement() ?? "silkworm"
        playerScore = 0
        return
      }
    }
    fatalError("Could not load start.txt from bundle")
  }

  func addNewWord() {
    let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    guard answer != rootWord else { wordError(title: "Original Word", message: "You can't submit the word itself.")
    return}
    guard answer.count > 3 else { wordError(title: "Word too short", message: "Be more creative.")
      return }
    guard isOriginal (word: answer) else {
        wordError(title: "Word used already", message: "Be more original.")
      return
    }
    guard isPossible (word: answer) else {
      wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
      return
    }
    guard isReal(word: answer) else {
      wordError(title: "Word not possible", message: "That isn't a real word.")
      return
    }
    addPoints(for: answer)
    usedWords.insert(answer, at: 0)
    newWord = ""
  }

  func addPoints(for word: String) {
    for letter in word {
      for entry in pointsList {
        if entry.value.contains(String(letter)) {
          playerScore += entry.key
        }
      }
    }
  }

  func isOriginal(word: String) -> Bool {
    !usedWords.contains(word)
  }

  func isPossible(word: String) -> Bool {
    var tempWord = rootWord
    for letter in word {
      guard let pos = tempWord.firstIndex(of: letter) else { return false }
      tempWord.remove(at: pos)
    }
    return true
  }

  func isReal(word: String) -> Bool {
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
    return misspelledRange.location == NSNotFound
  }

  func wordError(title: String, message: String) {
    errorTitle = title
    errorMessage = message
    showingError = true
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
