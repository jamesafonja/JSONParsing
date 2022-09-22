//
//  PhotoListViewModel.swift
//  JSONParsing
//
//  Created by Revive on 9/19/22.
//

import Foundation

class PhotoListViewModel: ViewModel, ObservableObject {
    let service: DataService
    @Published var statusMessage: String = ""
    @Published var hasError: Bool = false
    
    let photosUrlString = "https://jsonplaceholder.typicode.com/photos"
    
    @Published var photos = [Photo]()
    
    // Dependency Injection via init
    init(service: DataService) {
        self.service = service
    }
    
    func getPhotos(from urlString: String, completion: @escaping (_ success: Bool) -> Void) {
        service.getData(from: urlString) { [weak self] data, error in
            
            if let error = error {
                self?.hasError = true
                self?.statusMessage = error.localizedDescription
                completion(false)
                return
            }
            
            guard let data = data else {
                self?.hasError = true
                self?.statusMessage = "No photo data found"
                completion(false)
                return
            }
            
            do {
                let fetchedPhotos = try JSONDecoder().decode([Photo].self, from: data)
                DispatchQueue.main.async {
                    self?.photos = fetchedPhotos
                }
                self?.statusMessage = "Fetched photos successfully"
                self?.hasError = false
                completion(true)
            } catch let decoderError {
                self?.statusMessage = "Error decoding photo array: \(decoderError)"
                self?.hasError = true
                completion(false)
            }
        }
    }
}
