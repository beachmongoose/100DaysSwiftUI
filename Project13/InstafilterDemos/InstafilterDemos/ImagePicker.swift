//
//  ImagePicker.swift
//  InstafilterDemos
//
//  Created by Maggie Maldjian on 1/28/21.
//

import Foundation
import SwiftUI

typealias UIVewControllerType = UIImagePickerController

struct ImagePicker: UIViewControllerRepresentable {
  @Binding var image: UIImage?
  @Environment(\.presentationMode) var presentationMode
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  

  class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var parent: ImagePicker
      init(_ parent: ImagePicker) {
        self.parent = parent
      }
  
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      if let uiImage = info[.originalImage] as? UIImage {
        parent.image = uiImage
      }
      parent.presentationMode.wrappedValue.dismiss()
    }
  }

  func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator
    return picker
  }

  func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
  }
}
