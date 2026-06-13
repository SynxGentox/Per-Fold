//
//  Person.swift
//  Per-Fold
//
//  Created by Aryan Verma on 13/06/26.
//

import Foundation
import SwiftData

@Model
class Person {
    var profile: Profile
    var number: Int
    
    init(profile: Profile, number: Int) {
        self.profile = profile
        self.number = number
    }
}
