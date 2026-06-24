//
//  HomeView.swift
//  Per-Fold
//
//  Created by Aryan Verma on 15/06/26.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    let persistenceActor: PersistenceActor
    @State var homeVM: HomeVM
    
    init(persistenceActor: PersistenceActor) {
        self.persistenceActor = persistenceActor
        self._homeVM = State(initialValue: HomeVM(
            groupsRepo: GroupsRepositoryImpl(persistence: persistenceActor),
            expenseRepo: ExpenseRepositoryImpl(persistence: persistenceActor),
            personRepo: PersonRepositoryImpl(persistence: persistenceActor)))
    }
    let profile = ["bell", "person.circle.fill"]
    let buttonLabels = ["Add\nGroups", "Add\nMembers", "Pending"]
    let buttonLabels2 = ["Add\nExpense", "Pay", "Reminders", "History"]
    let searchText = ""
    
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
                    
                    CategoryGrid(homeVM: homeVM, title: "Bills")
                    CategoryGrid(homeVM: homeVM, title: "Top Spents")
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
    let container = try! ModelContainer(
        for: Person.self, Groups.self, Expense.self, Split.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    let actor = PersistenceActor(modelContainer: container)
    
    HomeView(persistenceActor: actor)
}
