//
//  ExpenseRepository.swift
//  Per-Fold
//
//  Created by Aryan Verma on 14/06/26.
//

import Foundation

protocol ExpenseRepository {
    func fetchExpense() async throws -> [ExpenseDTO]
    func addExpense(_ exp: ExpenseDTO) async throws
    func deleteExpense(_ exp: ExpenseDTO) async throws
}

final class ExpenseRepositoryImpl: ExpenseRepository {
    private let persistence: PersistenceActor
    
    init(persistence: PersistenceActor) {
        self.persistence = persistence
    }
    
    func fetchExpense() async throws -> [ExpenseDTO] {
        try await persistence.fetchExpense()
    }
    
    func addExpense(_ exp: ExpenseDTO) async throws {
        try await persistence.addExpense(exp)
    }
    
    func deleteExpense(_ exp: ExpenseDTO) async throws {
        try await persistence.deleteExpense(id: exp.id)
    }
}
