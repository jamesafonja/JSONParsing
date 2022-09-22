//
//  TodoListView.swift
//  JSONParsing
//
//  Created by Revive on 9/19/22.
//

import SwiftUI

struct TodoListView: View {
    @StateObject var vm: TodoListViewModel
    
    init() {
        let vm = TodoListViewModel(service: APIHandler())
        _vm = StateObject(wrappedValue: vm)
        vm.getTodos(from: vm.todoUrlString) { success in
            // Perform additaional actions
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(vm.todos) { todo in
                    VStack(alignment: .leading) {
                        Divider()
                        Text(todo.title)
                            .padding()
                    }
                }
            }
        }
        .navigationTitle("Todos")
        .alert(isPresented: $vm.hasError) {
            Alert(
                title: Text("Error"),
                message: Text(vm.statusMessage)
            )
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}
