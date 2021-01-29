//
//  ContentView.swift
//  Instafilter
//
//  Created by Maggie Maldjian on 1/28/21.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
  @State private var processedImage: UIImage?
  @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
  let context = CIContext()
  @State private var filterName = "Sepia Tone"
  @State private var showingFilterSheet = false
  @State private var showingImagePicker = false
  @State private var showingNoImageAlert = false
  @State private var inputImage: UIImage?
  @State private var image: Image?
  @State private var filterIntensity = 0.5
  @State private var filterRadius = 1.00
  @State private var filterScale = 8.00
  var body: some View {
    let intensity = Binding<Double>(
      get: {
        self.filterIntensity
      },
      set: {
        self.filterIntensity = $0
        self.applyProcessing()
      })

      let radius = Binding<Double>(
        get: {
          self.filterRadius
        },
        set: {
          self.filterRadius = $0
          self.applyProcessing()
        })

    let scale = Binding<Double>(
      get: {
        self.filterScale
      },
      set: {
        self.filterScale = $0
        self.applyProcessing()
      })

    return NavigationView {
      GeometryReader { geo in
        VStack {
          ZStack {
            Rectangle()
              .fill(Color.secondary)
              .frame(width: geo.size.width, height: geo.size.height / 1.3)
            if image != nil {
              image?
                .resizable()
                .scaledToFit()
            } else {
              Text("Tap to select a picture")
                .foregroundColor(.white)
                .font(.headline)
            }
          }
          .onTapGesture {
            self.showingImagePicker = true
          }
          Spacer()
          VStack {
            let inputKeys = currentFilter.inputKeys
            if inputKeys.contains(kCIInputIntensityKey) {
              HStack {
                Text("Intensity")
                Slider(value: intensity)
              }
            }
            if inputKeys.contains(kCIInputRadiusKey) {
              HStack {
                Text("Radius")
                Slider(value: radius)
              }
            }
            if inputKeys.contains(kCIInputScaleKey) {
              HStack {
                Text("Scale")
                Slider(value: scale)
              }
            }
          }
          Spacer()
          HStack {
            Button(filterName) {
              self.showingFilterSheet = true
            }

            Spacer()

            Button("Save") {
              guard self.image != nil else { self.showingNoImageAlert = true
                return
              }
              guard let processedImage = self.processedImage else { return }

              let imageSaver = ImageSaver()
              imageSaver.successHandler = {
                print("Success!")
              }

              imageSaver.errorHandler = {
                print("Oops: \($0.localizedDescription)")
              }
              imageSaver.writeToPhotoAlbum(image: processedImage)
            }
          }
        }
      }
      .padding([.horizontal, .bottom])
      .navigationTitle("Instafilter")
    }
    .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
      ImagePicker(image: self.$inputImage)
    }
    .alert(isPresented: $showingNoImageAlert) {
      Alert(title: Text("Error"), message: Text("No image."), dismissButton: .default(Text("OK")))
    }
    .actionSheet(isPresented: $showingFilterSheet) {
      ActionSheet(title: Text("Select a filter"), buttons: [
          .default(Text("Crystallize")) { self.setFilter(CIFilter.crystallize())
            filterName = "Crystallize"
          },
          .default(Text("Edges")) { self.setFilter(CIFilter.edges())
            filterName = "Edges"
          },
          .default(Text("Gaussian Blur")) { self.setFilter(CIFilter.gaussianBlur())
            filterName = "Gaussian Blur"
          },
          .default(Text("Pixellate")) { self.setFilter(CIFilter.pixellate())
            filterName = "Pixellate"
          },
          .default(Text("Sepia Tone")) { self.setFilter(CIFilter.sepiaTone())
            filterName = "Sepia Tone"
          },
          .default(Text("Unsharp Mask")) { self.setFilter(CIFilter.unsharpMask())
            filterName = "Unsharp Mask"
          },
          .default(Text("Vignette")) { self.setFilter(CIFilter.vignette())
            filterName = "Vignette"
          },
          .cancel()
      ])
    }
  }

  func setFilter(_ filter: CIFilter) {
    currentFilter = filter
    loadImage()
  }

  func loadImage() {
    guard let inputImage = inputImage else { return }
    let beginImage = CIImage(image: inputImage)
    currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
    applyProcessing()
  }

  func applyProcessing() {
    let inputKeys = currentFilter.inputKeys
    if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
    if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey) }
    if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey) }

    guard let outputImage = currentFilter.outputImage else { return }

    if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
      let uiImage = UIImage(cgImage: cgimg)
      image = Image(uiImage: uiImage)
      processedImage = uiImage
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
