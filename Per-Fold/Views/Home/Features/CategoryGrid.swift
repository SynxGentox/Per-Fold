//
//  CategoryGrid.swift
//  Per-Fold
//
//  Created by Aryan Verma on 16/06/26.
//

import SwiftUI

struct CategoryGrid: View {
    let homeVM: HomeVM?
    var body: some View {
        VStack {
            let column: [GridItem] = [
                GridItem(.adaptive(minimum: 100)),
                GridItem(.adaptive(minimum: 100))
            ]
            VStack {
                LazyVGrid(columns: column) {
                    ForEach(homeVM?.categoryTotals ?? [
                        (Categories.Recharge, 22.2),
                        (Categories.finance, 62.2),
                    ], id: \.key) { cat, value in
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
                LazyVGrid(columns: column) {
                    ForEach(homeVM?.categoryTotals ?? [
                        (Categories.Recharge, 22.2),
                        (Categories.finance, 62.2),
                        (Categories.food, 22.2),
                        (Categories.other, 22.2),
                        (Categories.shopping, 62.2),
                        (Categories.subscriptions, 22.2),
                        (Categories.theater, 62.2),
                        (Categories.utility, 22.2)
                    ], id: \.key) { cat, value in
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
                .padding(.horizontal)
            }
            .padding(8)
            .card(color: Color(.darkGray).opacity(0.5))
        }
    }
}

#Preview {
    CategoryGrid(homeVM: nil)
}
