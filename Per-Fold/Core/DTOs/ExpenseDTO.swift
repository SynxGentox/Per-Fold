//
//  ExpenseDTO.swift
//  Per-Fold
//
//  Created by Aryan Verma on 13/06/26.
//

import Foundation

struct ExpenseDTO: Sendable {
    let id: UUID
    let title: String
    let category: Categories
    let date: Date
    let paidBy: String
    let totalAmount: Double
    let splitAmount: [SplitDTO]
}

struct SplitDTO: Sendable {
    let id: UUID
    let person: String
    let amount: Double
    let isPaid: Bool
}
