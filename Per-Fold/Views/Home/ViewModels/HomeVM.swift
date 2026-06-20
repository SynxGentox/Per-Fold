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
    var groupsData: [GroupDTO] = []
    var totalOwed: Double = 0
    var expenseData: [ExpenseDTO] = []
    var personData: [PersonDTO] = []
    var categoryTotals: [(key: Categories, value: Double)] = []
    var isLoading = false
    var dataState: DataState = .isLoading
    var errorDesc: String = ""
    
    private let groupsRepo: GroupsRepository
    private let expenseRepo: ExpenseRepository
    private let personRepo: PersonRepository
    
    
    
    init(groupsRepo: GroupsRepository, expenseRepo: ExpenseRepository, personRepo: PersonRepository){
        self.groupsRepo = groupsRepo
        self.expenseRepo = expenseRepo
        self.personRepo = personRepo
    }
    
    var grouped: [Categories: [ExpenseDTO]] {
        Dictionary(grouping: expenseData, by: {$0.category})
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
    
    func fetchGroups() async {
        if !groupsData.isEmpty { dataState = .isLoading }
        do {
            let groupsResult = try await groupsRepo.fetchGroup()
//            let expenseResult = try await expenseRepo.fetchExpense()
//            let personResult = try await personRepo.fetchPerson()
            
            if groupsResult.isEmpty {
                dataState = .isEmpty
            } else {
                groupsData = groupsResult
            }
            
        } catch {
            dataState = .isError
            errorDesc = error.localizedDescription
        }
    }
    
    func fetchExpense() async {
        if !personData.isEmpty { dataState = .isLoading }
        do {
            let personResult = try await personRepo.fetchPerson()
            
            if personResult.isEmpty {
                dataState = .isEmpty
            } else {
                personData = personResult
            }
        } catch {
            dataState = .isError
            errorDesc = error.localizedDescription
        }
    }
    
    func fetchPerson() async {
        if !expenseData.isEmpty { dataState = .isLoading }
        do {
            let expenseResult = try await expenseRepo.fetchExpense()
            
            if expenseResult.isEmpty {
                dataState = .isEmpty
            } else {
                expenseData = expenseResult
            }
            
        } catch {
            dataState = .isError
            errorDesc = error.localizedDescription
        }
    }
    
    
}
