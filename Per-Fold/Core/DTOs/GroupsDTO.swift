//
//  GroupsDTO.swift
//  Per-Fold
//
//  Created by Aryan Verma on 13/06/26.
//

import Foundation

struct GroupDTO: Sendable {
    let id: UUID
    let name: String
    let image: Data?
    let members: [PersonDTO]
    let expense: [ExpenseDTO]
}
