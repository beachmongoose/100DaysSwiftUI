//
//  ContentView.swift
//  InstafilterDemos
//
//  Created by Maggie Maldjian on 1/28/21.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
  @State private var image: Image?
  @State private var inputImage: UIImage?
  @State private var showingImagePicker = false

  var body: some View {
    VStack {
      image?
        .resizable()
        .scaledToFit()
  
      Button("Select Image") {
        self.showingImagePicker = true
      }
    }
    .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
      ImagePicker(image: self.$inputImage)
    }
  }

  func loadImage() {
    guard let inputImage = inputImage else { return }
    image = Image(uiImage: inputImage)
    UIImageWriteToSavedPhotosAlbum(inputImage, nil, nil, nil)
    let imageSaver = ImageSaver()
    imageSaver.writeToPhotoAlbum(image: inputImage)
  }
}

class ImageSaver: NSObject {
  func writeToPhotoAlbum(image: UIImage) {
    UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
  }
  @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    print("Save complete")
  }
}

struct ImageView: View {
  @State private var image: Image?

  var body: some View {
    VStack {
      image?
        .resizable()
        .scaledToFit()
    }
    .onAppear(perform: loadImage)
  }

  func loadImage() {
//    image = Image("sleepingdogs")
    guard let inputImage = UIImage(named: "sleepingdogs") else { return }
    let beginImage = CIImage(image: inputImage)
    let context = CIContext()
    let currentFilter = CIFilter.sepiaTone()
    currentFilter.inputImage = beginImage
    currentFilter.intensity = 1

    guard let outputImage = currentFilter.outputImage else { return }
    if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
      let uiImage = UIImage(cgImage: cgimg)
      image = Image(uiImage: uiImage)
    }
  }
}

struct ActionSheetView: View {
  @State private var showingActionSheet = false
  @State private var backgroundColor = Color.white
  var body: some View {
    Text("Hello World")
      .frame(width: 300, height: 300)
      .background(backgroundColor)
      .onTapGesture {
        self.showingActionSheet = true
      }
      .actionSheet(isPresented: $showingActionSheet) {
        ActionSheet(title: Text("Change background"), message: Text("Select a new color"), buttons: [
          .default(Text("Red")) { self.backgroundColor = .red },
          .default(Text("Green")) { self.backgroundColor = .green},
          .default(Text("Blue")) { self.backgroundColor = .blue},
          .cancel()
        ])
    }
  }
}

struct GetSetValueView: View {
  @State private var blurAmount: CGFloat = 0
    var body: some View {
      let blur = Binding<CGFloat>(
        get: {
          self.blurAmount
        },
        set: {
          self.blurAmount = $0
          print("New value is \(self.blurAmount)")
        }
      )
      return VStack {
        Text("Hello, world!")
          .blur(radius: blurAmount)
        Slider(value: blur, in: 0...20)
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
