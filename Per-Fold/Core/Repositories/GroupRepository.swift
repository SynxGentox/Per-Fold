//
//  GroupRepository.swift
//  Per-Fold
//
//  Created by Aryan Verma on 13/06/26.
//

import Foundation

protocol GroupsRepository {
    func fetchGroup() async throws -> [GroupDTO]
    func addGroup(_ grp: GroupDTO) async throws
    func deleteGroup(_ grp: GroupDTO) async throws
}

final class GroupsRepositoryImpl: GroupsRepository {
    private let persistence: PersistenceActor
    
    init(persistence: PersistenceActor) {
        self.persistence = persistence
    }
    
    func fetchGroup() async throws -> [GroupDTO] {
        try await persistence.fetchGroup()
    }
    
    func addGroup(_ grp: GroupDTO) async throws {
        try await persistence.addGroup(grp)
    }
    
    func deleteGroup(_ group: GroupDTO) async throws {
        try await persistence.deleteGroup(id: group.id)
    }
}
