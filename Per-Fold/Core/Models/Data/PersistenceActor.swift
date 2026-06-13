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
    
    init(dataContainer: ModelContainer) {
        self.modelContainer = dataContainer
        let context = ModelContext(dataContainer)
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
    
    func addPerson(_ dto: PersonDTO) throws {
        let profile = Profile(
            id: dto.profile.id,
            name: dto.profile.name,
            image: dto.profile.image
        )
        let person = Person(profile: profile, number: dto.number)
        modelContext.insert(person)
        try modelContext.save()
    }
    
    func deletePerson(id: UUID) throws {
        let groups = try modelContext.fetch(FetchDescriptor<Person>())
        if let target = groups.first(where: { $0.profile.id == id }) {
            modelContext.delete(target)
            try modelContext.save()
        }
    }
    
    func addGroup(_ dto: GroupDTO) throws {
        let profile = Profile(
            id: dto.profile.id,
            name: dto.profile.name,
            image: dto.profile.image
        )
        let group = Groups(profile: profile, expense: [], members: [])
        modelContext.insert(group)
        try modelContext.save()
    }
    
    func deleteGroup(id: UUID) throws {
        let groups = try modelContext.fetch(FetchDescriptor<Groups>())
        if let target = groups.first(where: { $0.profile.id == id }) {
            modelContext.delete(target)
            try modelContext.save()
        }
    }
    
    private func mapToDTO(_ group: Groups) -> GroupDTO {
        GroupDTO(
            profile: group.profile,
            members: group.members.map { mapToDTO($0) },
            expense: group.expense.map { mapToDTO($0) }
        )
    }

    private func mapToDTO(_ person: Person) -> PersonDTO {
        PersonDTO(
            profile: person.profile,
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
