//
//  ChallengeView.swift
//  Drawing
//
//  Created by Maggie Maldjian on 1/21/21.
//

import SwiftUI

struct ChallengeView: View {
  @State private var width: CGFloat = 6
  var body: some View {
    VStack(spacing: 50) {
      Arrow()
        .stroke(Color.red, style: StrokeStyle(lineWidth: width, lineCap: .round, lineJoin: .round))
        .frame(width: 300, height: 300)
      HStack(spacing: 30) {
        Button("+ Stroke") {
          withAnimation(.linear(duration: 1)) {
            width += 6
          }
        }
        Button("- Stroke") {
          if width > 6 {
            withAnimation(.linear(duration: 1)) {
              width -= 6
            }
          }
        }
      }
    }
  }
}

struct Arrow: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()

    path.move(to: CGPoint(x: rect.midX, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
    path.addLine(to: CGPoint(x: rect.midX / 1.5, y: rect.midY))
    path.addLine(to: CGPoint(x: rect.midX / 1.5, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.maxX / 1.5, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.maxX / 1.5, y: rect.midY))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
    path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
    return path
  }
}

struct CyclingView: View {
  @State private var colorCycle = 0.0
  var body: some View {
    VStack(spacing: 20) {
      ColorCyclingRectangle(amount: self.colorCycle)
        .frame(width: 300, height: 300)
      Slider(value: $colorCycle)
    }
    .padding(30)
  }
}

struct ColorCyclingRectangle: View {
  var amount = 0.0
  var steps = 100

  var body: some View {

    ZStack {
      ForEach(0..<steps) { value in
        Rectangle()
          .inset(by: CGFloat(value))
          .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                                                            self.color(for: value, brightness: 1),
                                                            self.color(for: value, brightness: 0.5)
          ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
//          .strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
      }
    }
    .drawingGroup()
  }

  func color(for value: Int, brightness: Double) -> Color {
    var targetHue = Double(value) / Double(self.steps) + self.amount

    if targetHue > 1 {
      targetHue -= 1
    }

    return Color(hue: targetHue, saturation: 1, brightness: brightness)
  }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        CyclingView()
    }
}
