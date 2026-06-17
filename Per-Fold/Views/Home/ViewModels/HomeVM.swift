//
//  HomeVM.swift
//  Per-Fold
//
//  Created by Aryan Verma on 14/06/26.
//

import Foundation
import Observation

@Observable
@MainActor
final class HomeVM {
    var groups: [GroupDTO] = []
    var totalOwed: Double = 0
    var expense: [ExpenseDTO] = []
    var categoryTotals: [(key: Categories, value: Double)] = []
    private let groupData: GroupsRepository
    private let expenseData: ExpenseRepository
    
    
    private init(groupData: GroupsRepository, groups: [GroupDTO], totalOwed: Double, expense: [ExpenseDTO], expenseData: ExpenseRepository) async throws {
        self.groupData = groupData
        self.groups = groups
        self.totalOwed = totalOwed
        self.expense = try await expenseData.fetchExpense()
        self.expenseData = expenseData
    }
    
    var grouped: [Categories: [ExpenseDTO]] {
        Dictionary(grouping: expense, by: {$0.category})
    }
    
    func topCategories() {
        categoryTotals = grouped.mapValues { expenses in
            expenses.reduce(0) { $0 + $1.amount }
        }
        
        .sorted{ $0.value > $1.value }
    }
    
    var totalSpent: Double {
        grouped.values.reduce(0) { $0 + $1.reduce(0) {$0 + $1.amount} }
    }
    
}
