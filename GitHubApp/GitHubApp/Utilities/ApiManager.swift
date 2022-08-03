//
//  ApiManager.swift
//  GitHubApp
//
//  Created by Jan Binkiewicz on 29/07/2022.
//

import Foundation
import RealmSwift
import Alamofire

struct ApiManager {
    
    let apiKey = ""
    let apiUrl = "https://api.github.com/"
    
    let headers: HTTPHeaders = [
        "Authorization": "",
        "Accept": "application/vnd.github+json"
    ]
    
    struct DecodableType: Decodable { let url: String }
    
    // Get API data by URLSession
    func getUsers(_ user: String, onSuccess: @escaping (_ success: String) -> Void, onFailure: @escaping (_ failure: Any) -> Void) {
        
        if user != "" {
            
            if let url = URL(string: "\(self.apiUrl)search/users?q=\(user)+in:fullname") {
                
                URLSession.shared.fetchUsers(from: url) { data in
                    switch data {
                    case .success(let users):
                        
                        for userDekoded in users.items {
                            self.addUser(usedDecoder: userDekoded)
                        }
                        
                    case .failure(let err):
                        
                        print("Fetching failed with: \(err)")
                        onFailure(ErrorMessages.shared.checkErrorCode(.invalidResponse))
                    }
                }
            }
            else {
                onFailure(ErrorMessages.shared.checkErrorCode(.invalidRequest))
            }
        }
        else {
            onFailure(ErrorMessages.shared.checkErrorCode(.paramNotFound))
        }
    }
    
    // Get API data by Alamofire
    func getUsersAF(_ user: String, onSuccess: @escaping (_ success: String) -> Void, onFailure: @escaping (_ failure: Any) -> Void) {
        
        if user != "" {
            
            let url = "\(self.apiUrl)search/users?q=\(user)+in:fullname"
            AF.request(url, headers: ApiManager().headers).responseDecodable(of: DecodableType.self) { response in

                if let json = response.data {

                    do {
                        let decodedData = try JSONDecoder().decode(UserDecoder.self, from: json)
                        for userDecoder in decodedData.items {
                            self.addUser(usedDecoder: userDecoder)
                        }
                    }
                    catch let err {
                        onFailure(ErrorMessages.shared.checkErrorCode(.invalidResponse))
                        print(err.localizedDescription)
                    }
                }
                else {
                    onFailure(ErrorMessages.shared.checkErrorCode(.invalidResponse))
                }
            }
        }
        else {
            onFailure(ErrorMessages.shared.checkErrorCode(.paramNotFound))
        }
        
    }
    
    func addUser(usedDecoder: UserDecoder.Item) {
        
        if usedDecoder.login != "" {
            let userObject = UserObject(value: [
                "type":         usedDecoder.type,
                "repos_url":    usedDecoder.repos_url,
                "login":        usedDecoder.login,
                "organizations_url": usedDecoder.organizations_url,
                "url":          usedDecoder.url,
                "avatar_url":   usedDecoder.avatar_url,
                "html_url":     usedDecoder.html_url,
                "score":        String(usedDecoder.score),
                "toShow":       true,
                "visited":      false
            ])
            
            do {
                let realm = try Realm()

                let users = realm.objects(UserObject.self).filter("login == %@", usedDecoder.login)

                for c in users {
                    try! realm.write {
                        c.toShow = true
                    }
                }

                if users.count == 0 {
                    try realm.write {
                        realm.add(userObject)
                    }
                }
            } catch let error {
                print("addUser: \(error.localizedDescription)")
            }
        }
    }
    
    
}
