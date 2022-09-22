//
//  APIHandler.swift
//  JSONParsing
//
//  Created by Revive on 9/19/22.
//

import Foundation

protocol DataService {
    func getData(from urlString: String, completion: @escaping (_ data: Data?, _ error: Error?) -> Void)
}

class APIHandler: DataService, ObservableObject {
    
    func getData(
        from urlString: String,
        completion: @escaping (_ data: Data?, _ error: Error?) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completion(
                nil,
                NSError(domain: "Invalid url", code: 0, userInfo: nil)
            )
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(nil, error)
            } else if let data = data {
                completion(data, nil)
            }
        }
        .resume()
    }
    
}
