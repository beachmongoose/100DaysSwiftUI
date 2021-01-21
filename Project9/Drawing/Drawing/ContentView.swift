//
//  ContentView.swift
//  Drawing
//
//  Created by Maggie Maldjian on 1/20/21.
//

import SwiftUI

struct ContentView: View {
  @State private var rows = 4
  @State private var columns = 4

  var body: some View {
    Checkerboard(rows: rows, columns: columns)
      .onTapGesture {
        withAnimation(.linear(duration: 3)) {
          self.rows = 8
          self.columns = 16
        }
      }
  }
}

struct Checkerboard: Shape {
  var rows: Int
  var columns: Int

  public var animatableData: AnimatablePair<Double, Double> {
    get {
      AnimatablePair(Double(rows), Double(columns))
    }

    set {
      self.rows = Int(newValue.first)
      self.columns = Int(newValue.second)
    }
  }

  func path(in rect: CGRect) -> Path {
      var path = Path()

      let rowSize = rect.height / CGFloat(rows)
      let columnSize = rect.width / CGFloat(columns)

      for row in 0..<rows {
        for column in 0..<columns where (row + column).isMultiple(of: 2) {
            let startX = columnSize * CGFloat(column)
            let startY = rowSize * CGFloat(row)

            let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
            path.addRect(rect)
        }
      }
    return path
  }
}

struct AnimateTrapezoidView: View {
  @State private var insetAmount: CGFloat = 50

  var animatableData: CGFloat {
    get { insetAmount }
    set { self.insetAmount = newValue }
  }

  var body: some View {
    Trapezoid(insetAmount: insetAmount)
      .frame(width: 200, height: 100)
      .onTapGesture {
        withAnimation {
          self.insetAmount = CGFloat.random(in: 10...90)
        }
      }
  }
}

struct Trapezoid: Shape {
  var insetAmount: CGFloat

  func path(in rect: CGRect) -> Path {
    var path = Path()

    path.move(to: CGPoint(x: 0, y: rect.maxY))
    path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    path.addLine(to: CGPoint(x: 0, y: rect.maxY))

    return path
  }
}

struct AdjustmentsView: View {
  @State private var amount: CGFloat = 0.0
  var body: some View {
    VStack {
      Image("sleepingdogs")
        .resizable()
        .scaledToFit()
        .frame(width: 200, height: 200)
        .saturation(Double(amount))
        .blur(radius: (1 - amount) * 20)

      Slider(value: $amount)
        .padding()
    }
  }
}

struct ColorBlendView: View {
  @State private var amount: CGFloat = 0.0

  var body: some View {
    VStack {
      ZStack {
        Circle()
          .fill(Color.red)
          .frame(width: 200 * amount)
          .offset(x: -50, y: -80)
          .blendMode(.screen)

        Circle()
          .fill(Color.green)
          .frame(width: 200 * amount)
          .offset(x: 50, y: -80)
          .blendMode(.screen)

        Circle()
          .fill(Color.blue)
          .frame(width: 200 * amount)
          .blendMode(.screen)
      }
      .frame(width: 300, height: 300)

      Slider(value: $amount)
        .padding()
    }

    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.black)
    .edgesIgnoringSafeArea(.all)
  }
}

struct ImageBlendView: View {
  var body: some View {
//    ZStack {
//      Image("sleepingdogs")
//
//      Rectangle()
//        .fill(Color.red)
//        .blendMode(.multiply)
//    }
//    .frame(width: 400, height: 500)
//    .clipped()
    Image("sleepingdogs")
      .colorMultiply(.red)
  }
}

struct RenderingSpeedView: View {
  @State private var colorCycle = 0.0

  var body: some View {
    VStack {
      ColorCyclingCircle(amount: self.colorCycle)
        .frame(width: 300, height: 300)

      Slider(value: $colorCycle)
    }
  }
}

struct ColorCyclingCircle: View {
  var amount = 0.0
  var steps = 100

  var body: some View {
    ZStack {
      ForEach(0..<steps) { value in
        Circle()
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

struct FlowerView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0

    var body: some View {
        VStack {
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
              .fill(Color.red, style: FillStyle(eoFill: true))
//                .stroke(Color.red, lineWidth: 1)

            Text("Offset")
            Slider(value: $petalOffset, in: -40...40)
                .padding([.horizontal, .bottom])

            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding(.horizontal)
        }
    }
}

struct Flower: Shape {
    // How much to move this petal away from the center
    var petalOffset: Double = -20

    // How wide to make each petal
    var petalWidth: Double = 100

    func path(in rect: CGRect) -> Path {
        var path = Path()

        for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 8) {

            let rotation = CGAffineTransform(rotationAngle: number)

            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))

            let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width / 2))

            let rotatedPetal = originalPetal.applying(position)

            path.addPath(rotatedPetal)
        }

        return path
    }
}

struct ArcView: View {
  var body: some View {
    Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
      .strokeBorder(Color.blue, lineWidth: 10)
      .frame(width: 300, height: 300)
  }
}

struct Arc: InsettableShape {
  var startAngle: Angle
  var endAngle: Angle
  var clockwise: Bool
  var insetAmount: CGFloat = 0

  func path(in rect: CGRect) -> Path {
    let rotationAdjustment = Angle.degrees(90)
    let modifiedStart = startAngle - rotationAdjustment
    let modifiedEnd = endAngle - rotationAdjustment
    var path = Path()
    path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
    return path
  }

  func inset(by amount: CGFloat) -> some InsettableShape {
    var arc = self
    arc.insetAmount += amount
    return arc
  }
}

struct TriangleView: View {
  var body: some View {
    Triangle()
      .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
      .frame(width: 300, height: 300)
  }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct DrawPathView: View {
    var body: some View {
      Path { path in
        path.move(to: CGPoint(x: 200, y: 100))
        path.addLine(to: CGPoint(x: 100, y: 300))
        path.addLine(to: CGPoint(x: 300, y: 300))
        path.addLine(to: CGPoint(x: 200, y: 100))
      }
      .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
