//
//  ContentView.swift
//  iExpense
//
//  Created by Maggie Maldjian on 1/19/21.
//

import SwiftUI

struct ContentView: View {
  @State private var showingAddExpense = false
  @ObservedObject var expenses = Expenses()
  var body: some View {
    NavigationView {
      List {
        ForEach(expenses.items) { item in
          HStack {
              VStack(alignment: .leading) {
                  Text(item.name)
                      .font(.headline)
                  Text(item.type)
              }

              Spacer()
            if item.amount <= 10 {
              Text("$\(item.amount)")
                .lowAmount()
            } else if (item.amount > 10) && (item.amount < 50) {
              Text("$\(item.amount)")
                .medAmount()
            } else {
              Text("$\(item.amount)")
                .highAmount()
            }
          }
        }
        .onDelete(perform: removeItems)
      }
      .navigationBarTitle("iExpense")
      .navigationBarItems(leading: EditButton(), trailing:
                            Button(action: {
                              self.showingAddExpense = true
                            }) {
                              Image(systemName: "plus")
                            }
      )
      .sheet(isPresented: $showingAddExpense) {
        AddView(expenses: self.expenses)
      }
    }
  }
  func removeItems(at offsets: IndexSet) {
    expenses.items.remove(atOffsets: offsets)
  }
}

class Expenses: ObservableObject {
  @Published var items: [ExpenseItem] {
      didSet {
          let encoder = JSONEncoder()
          if let encoded = try? encoder.encode(items) {
              UserDefaults.standard.set(encoded, forKey: "Items")
          }
      }
  }
  init() {
    if let items = UserDefaults.standard.data(forKey: "Items") {
      let decoder = JSONDecoder()
      if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
        self.items = decoded
        return
      }
    }
    self.items = []
  }
}

struct LowAmount: ViewModifier {
  func body(content: Content) -> some View {
    content
      .foregroundColor(.green)
  }
}

struct MedAmount: ViewModifier {
  func body(content: Content) -> some View {
    content
      .foregroundColor(.orange)
  }
}

struct HighAmount: ViewModifier {
  func body(content: Content) -> some View {
    content
      .foregroundColor(.red)
  }
}

extension View {
  func lowAmount() -> some View {
    self.modifier(LowAmount())
  }
  func medAmount() -> some View {
    self.modifier(MedAmount())
  }
  func highAmount() -> some View {
    self.modifier(HighAmount())
  }
}

struct ExpenseItem: Identifiable, Codable {
  var id = UUID()
  let name: String
  let type: String
  let amount: Int
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
