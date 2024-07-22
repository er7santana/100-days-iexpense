//
//  AddView.swift
//  iExpense
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 21/07/24.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.locale) var locale
    @State private var name = ""
    @State private var type = ExpenseType.personal
    @State private var amount = 0.0
    var expenses: Expenses
    
    let types = ExpenseType.allCases
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0.title)
                    }
                }
                
                if #available(iOS 16, *) {
                    TextField("Amount",
                              value: $amount,
                              format: .currency(code: locale.currency?.identifier ?? "BRL") )
                    .keyboardType(.decimalPad)
                } else {
                    TextField("Amount",
                              value: $amount,
                              format: .currency(code: "BRL") )
                    .keyboardType(.decimalPad)
                }
                
            }
            .navigationTitle("Add new expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button("Save") {
                        let item = ExpenseItem(name: name,
                                               type: type.title,
                                               amount: amount)
                        expenses.allItems.append(item)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
