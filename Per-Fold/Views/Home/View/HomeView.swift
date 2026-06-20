//
//  HomeView.swift
//  Per-Fold
//
//  Created by Aryan Verma on 15/06/26.
//

import SwiftUI

struct HomeView: View {
    @State var homeVM: HomeVM = HomeVM(
        groupsRepo: GroupsRepositoryImpl(persistence: <#PersistenceActor#>),
        expenseRepo: ExpenseRepositoryImpl(persistence: <#PersistenceActor#>),
        personRepo: PersonRepositoryImpl(persistence: <#PersistenceActor#>))
    let profile = ["bell", "person.circle.fill"]
    let buttonLabels = ["Add\nGroups", "Add\nMembers", "Pending"]
    let buttonLabels2 = ["Add\nExpense", "Pay", "Reminders", "History"]
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 7) {
                    HStack {
                        Text("Search")
                            .padding()
                            .padding(.leading, 8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .card(color: Color(.darkGray).opacity(0.5))
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "bell")
                                .padding(8)
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "person.circle.fill")
                                .font(.largeTitle)
                        }
                    }
                    
                    HStack {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach (1..<4) { post in
                                    Image(systemName: "checkmark.rectangle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .padding(8)
                                        .frame(maxWidth: .infinity, minHeight: 230, maxHeight: 230)
                                        .clipShape(Rectangle())
                                }
                            }
                        }
                    }
                    
                    HStack {
                        Text("Total Spent")
                        Text(homeVM.totalSpent, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(.title)
                    }
                    .font(.title)
                    .padding(.vertical, 8)
                    
                    HStack {
                        ForEach (buttonLabels, id: \.self) { title in
                            Button {
                                
                            } label: {
                                Text(title)
                                    .padding(8)
                                    .padding(.vertical, 8)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .card(color: .black)
                        }
                    }
                    .padding(8)
                    .card(color: Color(.darkGray).opacity(0.5))
                }
                .padding(.horizontal, 8)
                
                Color.white
                    .frame(maxWidth: .infinity,  minHeight: 30, maxHeight: 30)
                
                let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
                
                VStack(spacing: 7) {
                    LazyVGrid(columns: columns) {
                        ForEach (buttonLabels2, id: \.self) { title in
                            Button {
                                
                            } label: {
                                Text(title)
                                    .padding(8)
                                    .padding(.vertical, 8)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .card(color: .black)
                        }
                    }
                    .padding(8)
                    .card(color: Color(.darkGray).opacity(0.5))
                    
                    CategoryGrid(homeVM: homeVM)
                    CategoryGrid(homeVM: homeVM)
                }
                .padding([.horizontal, .bottom], 8)
                
                VStack {
                    Button {
                    } label: {
                        Text("Recent Transaction")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.horizontal, 15)
            }
        }
        
        .task {
            await homeVM.fetchGroups()
            await homeVM.fetchPerson()
            await homeVM.fetchExpense()
        }
    }
}

#Preview {
    HomeView()
}
