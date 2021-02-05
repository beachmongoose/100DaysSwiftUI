//
//  AddPersonView.swift
//  PersonList
//
//  Created by Maggie Maldjian on 2/2/21.
//

import SwiftUI

struct AddPersonView: View {
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var peopleList: People
  @State private var firstName = ""
  @State private var lastName = ""
  @State var inputImage: UIImage?
  @State private var showingImagePicker = false
    var body: some View {
      GeometryReader { geo in
        NavigationView {
            Form {
              if inputImage != nil {
                Image(uiImage: inputImage!)
                  .resizable()
                  .scaledToFit()
                  .onTapGesture {
                    self.showingImagePicker = true
                  }
              } else {
                DefaultRectangle()
                  .onTapGesture {
                    self.showingImagePicker = true
                  }
              }
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
          .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
          }
          .navigationBarItems(trailing: Button("Save") {
            self.savePerson()
          })
        }
      }
    }

  func savePerson() {
    let imageName = UUID().uuidString
    saveImage(url: imageName)
    let person = Person(firstName: self.firstName, lastName: self.lastName, image: imageName)
    self.peopleList.people.append(person)
    FileManager().encode(people: peopleList.people)
    self.presentationMode.wrappedValue.dismiss()
  }

  func saveImage(url: String) {
    let fileManager = FileManager()
    guard let jpegData = inputImage?.jpegData(compressionQuality: 0.8) else { return }
    try? jpegData.write(to: fileManager.getDocumentsDirectory().appendingPathComponent(url), options: [.atomicWrite, .completeFileProtection])
  }
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

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
      AddPersonView()
    }
}
