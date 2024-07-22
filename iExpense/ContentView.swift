//
//  ContentView.swift
//  iExpense
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 21/07/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var expenses = Expenses()
    @State private var showingAddExpanse = false
    
    var body: some View {
        VStack {
            List {
                Section("Personal") {
                    ForEach(expenses.personalItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: "BRL"))
                                .foregroundStyle(item.amount > 4.0 ? Color.red : Color.accentColor)
                        }
                    }
                    .onDelete(perform: removePersonalItems)
                }
                
                Section("Business") {
                    ForEach(expenses.businessItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: "BRL"))
                                .foregroundStyle(item.amount > 4.0 ? Color.red : Color.accentColor)
                        }
                    }
                    .onDelete(perform: removeBusinessItems)
                }
            }
        }
        .navigationTitle("iExpense")
        .toolbar {
            Button("Add expense", systemImage: "plus") {
                showingAddExpanse = true
            }
            EditButton()
        }
        .sheet(isPresented: $showingAddExpanse) {
            AddView(expenses: expenses)
        }
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        for index in offsets {
            let personalItem = expenses.personalItems[index]
            if let allItemFoundIndex = expenses.allItems.firstIndex(where: { $0.id == personalItem.id }) {
                expenses.allItems.remove(at: allItemFoundIndex)
            }
        }
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        for index in offsets {
            let businessItem = expenses.businessItems[index]
            if let allItemFoundIndex = expenses.allItems.firstIndex(where: { $0.id == businessItem.id }) {
                expenses.allItems.remove(at: allItemFoundIndex)
            }
        }
    }
}

#Preview {
    NavigationView {
        ContentView()
    }
}
