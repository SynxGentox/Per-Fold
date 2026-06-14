//
//  PersistenceActor.swift
//  Per-Fold
//
//  Created by Aryan Verma on 13/06/26.
//

import Foundation
import SwiftData

actor PersistenceActor: ModelActor {
    let modelContainer: ModelContainer
    
    let modelExecutor: any ModelExecutor
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
        let context = ModelContext(modelContainer)
        self.modelExecutor = DefaultSerialModelExecutor(modelContext: context)
    }
    
    func fetchPerson() throws -> [PersonDTO] {
        let persons = try modelContext.fetch(FetchDescriptor<Person>())
        return persons.map { mapToDTO($0) }
    }

    func fetchGroup() throws -> [GroupDTO] {
        let groups = try modelContext.fetch(FetchDescriptor<Groups>())
        return groups.map { mapToDTO($0) }
    }
    
    func fetchExpense() throws -> [ExpenseDTO] {
        let expense = try modelContext.fetch(FetchDescriptor<Expense>())
        return expense.map { mapToDTO($0) }
    }
    
    func addPerson(_ dto: PersonDTO) throws {
        let person = Person(id: dto.id, name: dto.name, image: dto.image, number: dto.number)
        modelContext.insert(person)
        try modelContext.save()
    }
    
    func deletePerson(id: UUID) throws {
        let groups = try modelContext.fetch(FetchDescriptor<Person>())
        if let target = groups.first(where: { $0.id == id }) {
            modelContext.delete(target)
            try modelContext.save()
        }
    }
    
    func addGroup(_ dto: GroupDTO) throws {
        let group = Groups(id: dto.id, name: dto.name, image: dto.image, expense: [], members: [])
        modelContext.insert(group)
        try modelContext.save()
    }
    
    func deleteGroup(id: UUID) throws {
        let groups = try modelContext.fetch(FetchDescriptor<Groups>())
        if let target = groups.first(where: { $0.id == id }) {
            modelContext.delete(target)
            try modelContext.save()
        }
    }
    
    func addExpense(_ dto: ExpenseDTO) throws {
        let expense = Expense(
            id: dto.id,
            title: dto.title,
            category: dto.category,
            date: dto.date,
            paidBy: dto.paidBy,
            totalAmount: dto.totalAmount,
            splitAmount: []
        )
        modelContext.insert(expense)
        try modelContext.save()
    }
    
    func deleteExpense(id: UUID) throws {
        let expense = try modelContext.fetch(FetchDescriptor<Expense>())
        if let target = expense.first(where: { $0.id == id }) {
            modelContext.delete(target)
            try modelContext.save()
        }
    }
    
    private func mapToDTO(_ group: Groups) -> GroupDTO {
        GroupDTO(
            id: group.id,
            name: group.name,
            image: group.image,
            members: group.members.map { mapToDTO($0) },
            expense: group.expense.map { mapToDTO($0) }
        )
    }

    private func mapToDTO(_ person: Person) -> PersonDTO {
        PersonDTO(
            id: person.id,
            name: person.name,
            image: person.image,
            number: person.number,
        )
    }

    private func mapToDTO(_ expense: Expense) -> ExpenseDTO {
        ExpenseDTO(
            id: expense.id,
            title: expense.title,
            category: expense.category,
            date: expense.date,
            paidBy: expense.paidBy,
            totalAmount: expense.totalAmount,
            splitAmount: expense.splitAmount.map {
                SplitDTO(
                    id: $0.id,
                    person: $0.person,
                    amount: $0.amount,
                    isPaid: $0.isPaid
                )
            }
        )
    }
}
