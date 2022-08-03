//
//  ApiManager.swift
//  GitHubApp
//
//  Created by Jan Binkiewicz on 29/07/2022.
//

import Foundation
import RealmSwift
import Alamofire
import SwiftyJSON

struct ApiManager {
    
    let apiKey = ""
    let apiUrl = "https://api.github.com/"
    
    let headers: HTTPHeaders = [
        "Authorization": "",
        "Accept": "application/vnd.github+json"
    ]
    
    struct DecodableType: Decodable { let url: String }
    
    func getUsers(_ user: String, onSuccess: @escaping (_ success: String) -> Void, onFailure: @escaping (_ failure: Any) -> Void) {
        
        if user != "" {
            
            let url = "\(self.apiUrl)search/users?q=\(user)+in:fullname"
        
            AF.request(url, headers: ApiManager().headers).responseDecodable(of: DecodableType.self) { response in
            
                if let json = response.data {
                    
                    let decodedData = JSON(json)
                    
                    if decodedData["items"].exists() {
                    
                        for userObj in decodedData["items"] {
                            self.addUser(userObj.1)
                        }
                        
                        onSuccess("API success")
                    }
                    else {
                        onFailure(ErrorMessages.shared.checkErrorCode(.invalidResponse))
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
    
    func addUser(_ userObj: JSON) {
        
        var type              = ""
        var repos_url         = ""
        var login             = ""
        var organizations_url = ""
        var url               = ""
        var avatar_url        = ""
        var html_url          = ""
        var score             = 0

        if let typeStr = userObj["type"].string {
            type = typeStr
        }

        if let repos_urlStr = userObj["repos_url"].string {
            repos_url = repos_urlStr
        }

        if let loginStr = userObj["login"].string {
            login = loginStr
        }

        if let organizations_urlStr = userObj["organizations_url"].string {
            organizations_url = organizations_urlStr
        }

        if let urlStr = userObj["url"].string {
            url = urlStr
        }

        if let avatar_urlStr = userObj["avatar_url"].string {
            avatar_url = avatar_urlStr
        }

        if let html_urlStr = userObj["html_url"].string {
            html_url = html_urlStr
        }
        
        if let scoreStr = userObj["score"].int {
            score = scoreStr
        }
        
        if login != "" {
            let userObject = UserObject(value: [
                "type":         type,
                "repos_url":    repos_url,
                "login":        login,
                "organizations_url": organizations_url,
                "url":          url,
                "avatar_url":   avatar_url,
                "html_url":     html_url,
                "score":        String(score),
                "toShow":       true,
                "visited":      false
            ])

            do {
                let realm = try Realm()

                let users = realm.objects(UserObject.self).filter("login == %@", login)

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
