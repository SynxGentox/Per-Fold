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
    var id: UUID
    var name: String
    var image: Data?
    var number: Int
    
    init(id: UUID, name: String, image: Data?, number: Int) {
        self.number = number
        self.id = id
        self.name = name
        self.image = image
    }
}
