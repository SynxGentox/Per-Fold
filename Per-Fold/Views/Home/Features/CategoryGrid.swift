//
//  CategoryGrid.swift
//  Per-Fold
//
//  Created by Aryan Verma on 16/06/26.
//

import SwiftUI
import SwiftData

struct CategoryGrid: View {
    let expense: [(key: Categories, value: Double)]
    let title: String
    var body: some View {
        VStack {
            let columns = [GridItem(.flexible()), GridItem(.flexible())]

            VStack {
                Text(title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 8)
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(expense, id: \.key) { cat, value in
                        VStack {
                            Text(cat.rawValue)
                            Text(value.description)
                        }
                        .foregroundStyle(Color(.label))
                        .frame(maxWidth: .infinity, minHeight: 110)
                        .card(color: Color(.systemBackground))
                    }
                }
                
                DisclosureGroup {
                
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(expense, id: \.key) { cat, value in
                        VStack {
                            Text(cat.rawValue)
                            Text(value.description)
                        }
                        .foregroundStyle(Color(.label))
                        .frame(maxWidth: .infinity, minHeight: 110)
                        .card(color: Color(.systemBackground))
                    }
                }
                } label: {
                    Text("More")
                        .foregroundStyle(Color(.label))
                }
                .padding(.vertical, 2)
                .padding(.horizontal, 8)
            }
            .padding(8)
            .card(color: Color(.darkGray).opacity(0.5))
        }
    }
}

#Preview {
    let container = try! ModelContainer(
        for: Person.self, Groups.self, Expense.self, Split.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    let actor = PersistenceActor(modelContainer: container)
    
    CategoryGrid(expense: [], title: "demo")
}
