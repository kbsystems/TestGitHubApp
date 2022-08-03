//
//  UserObject.swift
//  GitHubApp
//
//  Created by Jan Binkiewicz on 29/07/2022.
//

import Foundation
import RealmSwift

class UserObject: Object {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var type: String
    @Persisted var repos_url: String
    @Persisted var login: String
    @Persisted var organizations_url: String
    @Persisted var url: String
    @Persisted var avatar_url: String
    @Persisted var html_url: String
    @Persisted var score: String
    @Persisted var visited: Bool = false
    @Persisted var toShow: Bool = false
}
