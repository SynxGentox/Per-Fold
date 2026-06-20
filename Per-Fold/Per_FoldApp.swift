//
//  Per_FoldApp.swift
//  Per-Fold
//
//  Created by Aryan Verma on 05/06/26.
//

import SwiftUI
import SwiftData

@main
struct Per_FoldApp: App {
    let modelContainer: ModelContainer
    let persistenceActor: PersistenceActor
    
    init() {
        do {
            modelContainer = try ModelContainer(for: Person.self, Expense.self, Groups.self, Split.self)
            persistenceActor = PersistenceActor(modelContainer: modelContainer)
        } catch {
            fatalError("ModelContainer error: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView(persistenceActor: persistenceActor)
        }
    }
}
