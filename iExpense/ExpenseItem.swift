//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 21/07/24.
//

import Foundation

enum ExpenseType: CaseIterable {
    case business
    case personal
    
    var title: String {
        switch self {
        case .business:
            return "Business"
        case .personal:
            return "Personal"
        }
    }
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
