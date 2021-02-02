//
//  AddPersonView.swift
//  PersonList
//
//  Created by Maggie Maldjian on 2/2/21.
//

import SwiftUI

struct AddPersonView: View {
  @State private var firstName = ""
  @State private var lastName = ""
  @State var inputImage: UIImage?
  @State private var showingImagePicker = false
    var body: some View {
      GeometryReader { geo in
        NavigationView {
          VStack {
            ZStack {
              if inputImage != nil {
                Image(uiImage: inputImage!)
                  .resizable()
                  .scaledToFit()
                  .frame(width: geo.size.width / 1.1, height: geo.size.width / 1.1)
              } else {
                DefaultRectangle()
                  .frame(width: geo.size.width / 1.1, height: geo.size.width / 1.1)
              }
            }
            .onTapGesture {
              self.showingImagePicker = true
            }
            Form {
              HStack(spacing: 10) {
                Text("First:")
                  .fontWeight(.bold)
                TextField("First name", text: $firstName)
                  .disabled(inputImage == nil)
              }
              HStack(spacing: 10) {
                Text("Last:")
                  .fontWeight(.bold)
                TextField("Last name", text: $lastName)
                .disabled(inputImage == nil)
              }
            }
          }
          .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
          }
          .navigationBarItems(trailing: Button("Save") {
            self.saveImage()
          })
        }
      }
    }

  func saveImage() {
    
  }

  struct DefaultRectangle: View {
    var body: some View {
      ZStack {
        Rectangle()
          .fill(Color.secondary)
        Text("+ Add Image")
          .foregroundColor(.white)
          .fontWeight(.bold)
      }
    }
  }
}

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
      AddPersonView()
    }
}
