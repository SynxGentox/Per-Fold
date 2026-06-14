//
//  Group.swift
//  Per-Fold
//
//  Created by Aryan Verma on 13/06/26.
//

import Foundation
import SwiftData

@Model
class Groups {
    var id: UUID
    var name: String
    var image: Data?
    var expense: [Expense]
    var members: [Person]
    
    init(id: UUID, name: String, image: Data?, expense: [Expense], members: [Person]) {
        self.expense = expense
        self.members = members
        self.id = id
        self.name = name
        self.image = image
    }
}
