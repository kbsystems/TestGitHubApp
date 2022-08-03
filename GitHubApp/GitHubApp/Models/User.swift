//
//  User.swift
//  GitHubApp
//
//  Created by Jan Binkiewicz on 29/07/2022.
//

import Foundation
import RealmSwift

struct User: Identifiable {
    
    var id: String
    var type: String
    var repos_url: String
    var login: String
    var organizations_url: String
    var url: String
    var avatar_url: String
    var html_url: String
    var score: String
    var visited: Bool = false
    var toShow: Bool = false
    
    init(userObject: UserObject) {
        self.id                = userObject.id.stringValue
        self.type              = userObject.type
        self.repos_url         = userObject.repos_url
        self.login             = userObject.login
        self.organizations_url = userObject.organizations_url
        self.url               = userObject.url
        self.avatar_url        = userObject.avatar_url
        self.html_url          = userObject.html_url
        self.score             = userObject.score
        self.visited           = userObject.visited
        self.toShow            = userObject.toShow
    }
    
    init() { // init dla preview
        
        self.id                = "1"
        self.type              = ""
        self.repos_url         = ""
        self.login             = "GitHubUser"
        self.organizations_url = ""
        self.url               = ""
        self.avatar_url        = ""
        self.html_url          = ""
        self.score             = ""
        self.visited           = true
        self.toShow            = true
    }
}
