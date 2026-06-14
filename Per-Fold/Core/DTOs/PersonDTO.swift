//
//  PersonDTO.swift
//  Per-Fold
//
//  Created by Aryan Verma on 13/06/26.
//

import Foundation

struct PersonDTO: Sendable {
    let id: UUID
    let name: String
    let image: Data?
    let number: Int
}
