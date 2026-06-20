//
//  CategoryGrid.swift
//  Per-Fold
//
//  Created by Aryan Verma on 16/06/26.
//

import SwiftUI

struct CategoryGrid: View {
    let homeVM: HomeVM
    var body: some View {
        VStack {
            let columns = [GridItem(.flexible()), GridItem(.flexible())]

            VStack {
                Text("Bills")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 8)
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(homeVM.categoryTotals.prefix(4), id: \.key) { cat, value in
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
                        ForEach(homeVM.categoryTotals, id: \.key) { cat, value in
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
    CategoryGrid(homeVM: HomeVM(groupsRepo: <#T##any GroupsRepository#>, expenseRepo: <#T##any ExpenseRepository#>, personRepo: <#T##any PersonRepository#>))
}
