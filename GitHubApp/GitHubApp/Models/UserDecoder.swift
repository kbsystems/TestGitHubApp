//
//  UserDecoder.swift
//  GitHubApp
//
//  Created by Jan Binkiewicz on 03/08/2022.
//

import Foundation

struct UserDecoder: Codable {
    
    var total_count: Int
    var incomplete_results: Bool
    var items: Array<Item>
    
    struct Item: Codable {
        
        var login: String
        var type: String
        var repos_url: String
        var organizations_url: String
        var url: String
        var avatar_url: String
        var html_url: String
        var score: Int
        var id: Int
    }
}
