//: A UIKit based Playground for presenting user interface
  
import SwiftUI
import PlaygroundSupport

//Alert
struct ContentView: View {
  @State private var showingAlert = false
  var body: some View {
    Button("Show Alert") {
      self.showingAlert = true
    }
    .alert(isPresented: $showingAlert) {
      Alert(title: Text("Hello SwiftUI!"), message: Text("This is some detail I guess"), dismissButton: .default(Text("OK")))
    }
  }
}

struct ButtonTypesView: View {
  var body: some View {
    Button(action: {
      print("Button was tapped")
    }) {
      HStack(spacing: 10) {
        Image(systemName: "pencil")
        Text("Edit")
      }
    }
  }
}

struct GradientView: View {
  var body: some View {
    ZStack {
      AngularGradient(gradient: Gradient(colors: [.red, .green, .yellow, .blue, .purple, .red]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
      Text("Your content")
    }
//    ZStack {
//      RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 20, endRadius: 200)
//      Text("Your content")
//    }
  }
}

struct StackView: View {
  var body: some View {
    VStack(spacing: 5) {
      ForEach(0..<3) { _ in
        HStack(spacing: 20) {
          Text("O")
          Text("O")
          Text("O")
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
      ContentView()
  }
}
