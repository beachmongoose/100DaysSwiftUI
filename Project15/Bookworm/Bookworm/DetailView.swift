//
//  DetailView.swift
//  Bookworm
//
//  Created by Maggie Maldjian on 1/25/21.
//

import CoreData
import SwiftUI

struct DetailView: View {
  var book: Book

  @Environment(\.managedObjectContext) var moc
  @Environment(\.presentationMode) var presentationMode
  @State private var showingDeleteAlert = false
  var body: some View {
    GeometryReader { geometry in
      VStack {
        ZStack(alignment: .bottomTrailing) {
          Image(self.book.genre ?? "Other")
            .frame(maxWidth: geometry.size.width)

          Text(self.book.genre?.uppercased() ?? "OTHER")
            .font(.caption)
            .fontWeight(.black)
            .padding(8)
            .foregroundColor(.white)
            .background(Color.black.opacity(0.75))
            .clipShape(Capsule())
            .offset(x: -5, y: -5)
        }
        Text(self.book.author ?? "Unknown Author")
          .font(.title)
          .foregroundColor(.secondary)

        Text(self.book.review ?? "No review" )
          .padding()

        RatingView(rating: .constant(Int(self.book.rating)))
          .font(.largeTitle)

        Spacer()
        Text("Added \((book.date ?? Date()).stringDate)")
      }
    }
    .alert(isPresented: $showingDeleteAlert) {
      Alert(title: Text("Delete book"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
        self.deleteBook()
      }, secondaryButton: .cancel()
      )
    }
    .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
    .navigationBarItems(trailing: Button(action: {
      self.showingDeleteAlert = true
    }) {
      Image(systemName: "trash")
    })
  }
  func deleteBook() {
    moc.delete(book)

    try? self.moc.save()
    presentationMode.wrappedValue.dismiss()
  }
}

extension Date {
  var stringDate: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter.string(from: self)
  }
}

struct DetailView_Previews: PreviewProvider {
  static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
  static var previews: some View {
    let book = Book(context: moc)
    book.title = "Test book"
    book.author = "Test author"
    book.genre = "Fantasy"
    book.rating = 4
    book.review = "This was a great book; I really enjoyed it."

    return NavigationView {
      DetailView(book: book)
    }
  }
}
