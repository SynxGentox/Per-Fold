//
//  PersonRepository.swift
//  Per-Fold
//
//  Created by Aryan Verma on 14/06/26.
//

import Foundation
import SwiftData

protocol PersonRepository {
    func fetchPerson() async throws -> [PersonDTO]
    func addPerson(_ person: PersonDTO) async throws
    func deletePerson(_ person: PersonDTO) async throws
}

final class PersonRepositoryImpl: PersonRepository {
    private let persistence: PersistenceActor
    
    init(persistence: PersistenceActor) {
        self.persistence = persistence
    }
    
    func fetchPerson() async throws -> [PersonDTO] {
        try await persistence.fetchPerson()
    }
    
    func addPerson(_ person: PersonDTO) async throws {
        try await persistence.addPerson(person)
    }
    
    func deletePerson(_ person: PersonDTO) async throws {
        try await persistence.deletePerson(id: person.id)
    }
}
