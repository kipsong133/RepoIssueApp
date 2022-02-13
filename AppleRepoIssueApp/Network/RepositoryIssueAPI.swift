//
//  RepositoryAPI.swift
//  AppleRepoIssueApp
//
//  Created by 김우성 on 2022/02/13.
//

import Foundation

struct RepositoryIssueAPI {
    static let scheme = "https"
    static let host = "api.github.com"
    static let path = "/repos/"
    
    func searchRepoIssue(query: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = RepositoryIssueAPI.scheme
        components.host = RepositoryIssueAPI.host
        components.path = RepositoryIssueAPI.path + query + "/issues"
        return components
    }
}
