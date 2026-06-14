//
//  Expense.swift
//  Per-Fold
//
//  Created by Aryan Verma on 13/06/26.
//

import Foundation
import SwiftData

@Model
class Expense: Identifiable {
    var id: UUID
    var title: String
    var category: Categories
    var date: Date
    var paidBy: String
    var totalAmount: Double
    var splitAmount: [Split]
    
    init(id: UUID, title: String, category: Categories, date: Date, paidBy: String, totalAmount: Double, splitAmount: [Split]) {
        self.id = id
        self.title = title
        self.category = category
        self.date = date
        self.paidBy = paidBy
        self.totalAmount = totalAmount
        self.splitAmount = splitAmount
    }
}

@Model
class Split: Identifiable {
    var id: UUID
    var person: String
    var amount: Double
    var isPaid: Bool
    
    init(id: UUID, person: String, amount: Double, isPaid: Bool) {
        self.id = id
        self.person = person
        self.amount = amount
        self.isPaid = isPaid
    }
}
