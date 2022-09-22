//
//  TodoListViewModel.swift
//  JSONParsing
//
//  Created by Revive on 9/19/22.
//

import Foundation

class TodoListViewModel: ViewModel, ObservableObject {
    let service: DataService
    @Published var statusMessage: String = ""
    @Published var hasError: Bool = false
    
    @Published var todos = [Todo]()

    let todoUrlString = "https://jsonplaceholder.typicode.com/todos"

    // Dependency injection via init
    init(service: DataService) {
        self.service = service
    }
    
    func getTodos(from urlString: String, completion: @escaping (_ success: Bool) -> Void) {
        service.getData(from: urlString) { [weak self] data, error in
            if let error = error {
                self?.statusMessage = error.localizedDescription
                self?.hasError = true
                completion(false)
                return
            }
            
            guard let data = data else {
                self?.statusMessage = "No data found"
                self?.hasError = true
                completion(false)
                return
            }
            
            do {
                let fetchedTodos = try JSONDecoder().decode([Todo].self, from: data)
                DispatchQueue.main.async {
                    self?.todos = fetchedTodos
                    self?.statusMessage = "Successfully fetched todos"
                    self?.hasError = false
                    completion(true)
                }
            } catch let decoderError {
                DispatchQueue.main.async {
                    self?.statusMessage = decoderError.localizedDescription
                    self?.hasError = true
                    completion(false)
                }
            }
        }
    }
}
