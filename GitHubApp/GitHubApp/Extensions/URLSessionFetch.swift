//
//  URLSessionFetchUser.swift
//  GitHubApp
//
//  Created by Jan Binkiewicz on 03/08/2022.
//

import Foundation

extension URLSession {
    
    func fetchUsers(from url: URL, completion: @escaping (Result<UserDecoder, Error>) -> Void) {
        self.dataTask(with: url) { (data, res, err) in
            if let err = err {
                completion(.failure(err))
            }
            if let data = data {
                do {
                    // Convert the JSON data into an array of UserDecoder objects:
                    let users = try JSONDecoder().decode(UserDecoder.self, from: data)
                    completion(.success(users))
                } catch let err {
                    completion(.failure(err))
                }
            }
        }.resume()
    }
}
