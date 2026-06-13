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
    var profile: Profile
    var expense: [Expense]
    var members: [Person]
    
    init(profile: Profile, expense: [Expense], members: [Person]) {
        self.profile = profile
        self.expense = expense
        self.members = members
    }
}
