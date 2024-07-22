//
//  Expenses.swift
//  iExpense
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 21/07/24.
//

import SwiftUI

class Expenses: ObservableObject {
    @Published var allItems = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(allItems) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
            personalItems = allItems.filter { $0.type == ExpenseType.personal.title }.sorted(by: { $0.name < $1.name })
            businessItems = allItems.filter { $0.type == ExpenseType.business.title }.sorted(by: { $0.name < $1.name })
        }
    }
    
    @Published var personalItems = [ExpenseItem]()
    @Published var businessItems = [ExpenseItem]()
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items"),
           let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
            allItems = decodedItems
            return
        }
        
        allItems = []
    }
}
