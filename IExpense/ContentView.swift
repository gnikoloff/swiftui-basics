//
//  ContentView.swift
//  IExpense
//
//  Created by Georgi Nikolov on 04.02.22.
//

import SwiftUI

struct User: Codable {
    let firstName: String
    let lastName: String
}

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                // Here we don't need to specify id manually, because "item" conforms to the Identifiable protocol!!!
                ForEach(expenses.items) { item in
                    ForEach(expenses.items) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            Text(item.amount, format: .currency(code: "USD"))
                        }
                    }
                }
                .onDelete(perform: onDelete)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    func onDelete (at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    // PERSIST STRUCT TO USERDEFAULTS STORAGR
//    @State private var user = User(firstName: "Georgi", lastName: "Nikolov")
//    var body: some View {
//        Button("Save user") {
//            let encoder = JSONEncoder()
//            if let data = try? encoder.encode(user) {
//                UserDefaults.standard.set(data, forKey: "UserData")
//            }
//        }
//    }
    
    // EDIT DELETE ACTIONS
//    @State private var numbers = [Int]()
//    @State private var currentNumber = 1
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                List {
//                    ForEach(numbers, id: \.self) { number in
//                        Text("Row \(number)")
//                    }
//                    .onDelete(perform: removeRows)
//                }
//                Button("Add Number") {
//                    numbers.append(currentNumber)
//                    currentNumber += 1
//                }
//            }
//            .navigationTitle("onDelete()")
//            .toolbar {
//                EditButton()
//            }
//        }
//    }
//    func removeRows(at offsets: IndexSet) {
//        numbers.remove(atOffsets: offsets)
//    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
