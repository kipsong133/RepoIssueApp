//
//  RepoIssue.swift
//  AppleRepoIssueApp
//
//  Created by 김우성 on 2022/02/13.
// https://api.github.com/repos/apple/swift/issues

import Foundation

struct RepoIssue: Decodable {
    var url: String?
    var title: String?
    var id: Int?
    var issueContent: String?
    var user: User?
    
    enum CodingKeys: String, CodingKey {
        case title, id, user
        case url = "html_url"
        case issueContent = "body"
    }
}

struct User: Decodable {
    var imageURL: String?
    var username: String?
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "avatar_url"
        case username = "login"
    }
}
