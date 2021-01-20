//
//  AddView.swift
//  iExpense
//
//  Created by Maggie Maldjian on 1/19/21.
//

import SwiftUI

struct AddView: View {
  @Environment(\.presentationMode) var presentationMode
  @State private var name = ""
  @State private var type = "Personal"
  @State private var amount = ""
  @ObservedObject var expenses: Expenses
  @State private var amountError = false

  static let types = ["Business", "Personal"]

  var body: some View {
    NavigationView {
      Form {
        TextField("Name", text: $name)
        Picker("Type", selection: $type) {
          ForEach(Self.types, id: \.self) {
            Text($0)
          }
        }
        TextField("Amount", text: $amount)
          .keyboardType(.numberPad)
      }
      .navigationBarTitle("Add new expense")
      .navigationBarItems(trailing: Button("Save") {
        if let actualAmount = Int(self.amount) {
          let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
          self.expenses.items.append(item)
          self.presentationMode.wrappedValue.dismiss()
        }
        else {
          amountError = true
        }
      })
    }
    .alert(isPresented: $amountError) {
      Alert(title: Text("Error"), message: Text("Invalid Amount"), dismissButton: .default(Text("OK")))
    }
  }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
      AddView(expenses: Expenses())
    }
}